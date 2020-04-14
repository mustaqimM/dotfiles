#!/usr/bin/env bash

# exit on all errors
set -e

#
# root has to run the script
#
if [ `whoami` != "root" ]
    then
    printf "You need to be root to do this!\nIf you have SUDO installed, then run this script with sudo \$script.bash\n"
    exit 1
fi

CHECKCONF=`(which unbound-checkconf)`
CONTROL=`(which unbound-control)`

CacheDump=$(mktemp)

dest="/var/lib/unbound"
zonedir="/etc/unbound/zones"

mkdir -p "${dest}"

find "${dest}/" -type f -name "*.zone*" -delete

for zones in `wget -qO- 'https://gitlab.com/my-privacy-dns/rpz-dns-firewall-tools/unbound/raw/master/source.txt'`
do
        wget -q "${zones}" --directory-prefix="${dest}/"
done

if [ -f "${zonedir}/rpz.db" ]
then
    rm "${zonedir}/rpz.db"
fi

for zones in $(find "${dest}/" -name "*.zone")
do
    cat "${zones}" >> "${zonedir}/rpz.db"
done

printf "\nDone Parsing input\n\nNow Sort the rpz.db\n"

sort -u -f "${zonedir}/rpz.db" -o "${zonedir}/rpz.db"

printf "\nSorted ${zonedir}/rpz.db\n\nReload Unbound\n"

"${CHECKCONF}" > /dev/null 2>&1
if [ $? == 0 ]
then
        "${CONTROL}" dump_cache >> "${CacheDump}"
        "${CONTROL}" reload > /dev/null 2>&1
        "${CONTROL}" load_cache < "${CacheDump}" && rm "${CacheDump}"
        if [ -t 1 ]
        then
        printf "You're unbound NXDOMAINs have been updated\nreloading unbound server\n"
        else
        printf "Something went wrong\n"
        fi
        exit 0
else
        printf "The program got terminated by an error\n\nPlease see log for detail\n"
        exit 1
fi