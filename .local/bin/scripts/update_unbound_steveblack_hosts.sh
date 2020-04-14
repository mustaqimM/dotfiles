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

fd . "${dest}/" -e hosts -x rm

curl -f https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o "${dest}/hosts"

if [ -f "${zonedir}/rpz.db" ]
then
    rm "${zonedir}/rpz.db"
    touch "${zonedir}/rpz.db"
fi

rg '^0\.0\.0\.0' "${dest}/hosts" | awk '{if(NR>1)print "local-zone: \""$2"\" always_nxdomain"}' > "${zonedir}/rpz.db"

"${CHECKCONF}" > /dev/null 2>&1
if [ $? == 0 ]
then
        "${CONTROL}" dump_cache >> "${CacheDump}"
        "${CONTROL}" reload > /dev/null 2>&1
        "${CONTROL}" load_cache < "${CacheDump}" && rm "${CacheDump}"
        if [ -t 1 ]
        then
        printf "Your unbound NXDOMAINs have been updated\nreloading unbound server\n"
        else
        printf "Something went wrong\n"
        fi
        exit 0
else
        printf "The program got terminated by an error\n\nPlease see log for detail\n"
        exit 1
fi
