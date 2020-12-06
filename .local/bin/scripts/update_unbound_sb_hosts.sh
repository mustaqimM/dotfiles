#!/usr/bin/env bash

# exit on all errors
set -e

#
# root has to run the script
#
if [ "$(whoami)" != "root" ]
then
  printf '\nYou need to be \e[4m\e[31mroot\e[0m for this!\nIf you have sudo installed, then run this script with:\n\n$ \e[31msudo \e[34m%s\e[0m \n' "$(basename "$0")"
  exit 1
fi

CHECKCONF=$(which unbound-checkconf)
CONTROL=$(which unbound-control)

CacheDump=$(mktemp)

dest="/var/lib/unbound"
zonedir="/etc/unbound/zones"

mkdir -p "${dest}"

fd . "${dest}/" -e hosts -x rm

#curl -f https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o "${dest}/hosts"
cd /; aria2c --no-conf --allow-overwrite=true 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' -o "/var/lib/unbound/hosts"

if [ -f "${zonedir}/rpz.db" ]
then
  rm "${zonedir}/rpz.db"
  touch "${zonedir}/rpz.db"
fi

rg '^0\.0\.0\.0' "${dest}/hosts" | awk '{if(NR>1)print "local-zone: \""$2"\" always_nxdomain"}' > "${zonedir}/rpz.db"

if "${CHECKCONF}" > /dev/null 2>&1
then
  "${CONTROL}" dump_cache >> "${CacheDump}"
  "${CONTROL}" reload > /dev/null 2>&1
  "${CONTROL}" load_cache < "${CacheDump}" && rm "${CacheDump}"
if [ -t 1 ]
then
  printf "\nYour unbound NXDOMAINs have been updated\nreloading unbound server\n"
else
  printf "\n\e[31mSomething went wrong\n"
fi
exit 0
else
  printf "The program got terminated by an error\n\nPlease see log for detail\n"
  exit 1
fi
