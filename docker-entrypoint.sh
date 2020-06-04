#!/bin/bash

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_LOG_FILE=/var/log/munin/munin-node-configure.log

if [ ! -z "$ALLOW" ]; then
    if [ ! -f $MUNIN_CONFIGURATION_FILE.applied ]; then
        echo $ALLOW >> $MUNIN_CONFIGURATION_FILE
        touch $MUNIN_CONFIGURATION_FILE.applied
    fi
fi

sed -i 's/background 1/background 0/;s/setsid 1/setsid 0/;/^log_file/d' /etc/munin/munin-node.conf

if [ ! -z "$PLUGINS" ]; then
  IFS=, read -a plugins <<< "${PLUGINS%;}"
  for i in "${plugins[@]}"; do 
    IFS=: read -a plugin <<< "${i%;}"
    pname="${plugin%%:*}"; plink="${plugin#*:}"
    ln -sf /usr/lib/munin/plugins/$pname /etc/munin/plugins/$plink
  done
fi

exec "$@"
