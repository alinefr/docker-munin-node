#!/bin/sh

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_LOG_FILE=/var/log/munin/munin-node-configure.log

if [ ! -z "$ALLOW" ]; then
    if [ ! -f $MUNIN_CONFIGURATION_FILE.applied ]; then
        echo $ALLOW >> $MUNIN_CONFIGURATION_FILE
        touch $MUNIN_CONFIGURATION_FILE.applied
    fi        
fi

for i in `ls /usr/lib/munin/plugins/`; do 
  ln -sf /usr/lib/munin/plugins/$i /etc/munin/plugins/$i 2>&1 >/dev/null
done

/usr/sbin/munin-node
