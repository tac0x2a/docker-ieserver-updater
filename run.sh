#!/bin/sh

echo ruby /work/ddns-update.rb -u $USERNAME -d $DOMAIN -p $PASSWORD -c /work/volume/current_ip -l /work/volume/logfile.log -s "$CRON_SCHEDULE" >> /work/volume/sh.txt
ruby /work/ddns-update.rb -u $USERNAME -d $DOMAIN -p $PASSWORD -c /work/volume/current_ip -l /work/volume/logfile.log -s "$CRON_SCHEDULE"
