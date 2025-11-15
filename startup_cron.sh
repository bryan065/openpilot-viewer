#!/bin/bash

mkdir -p /data/cron
chown -R 1000:100 /data/cron

# ensure permissions/user on container start
chown -R root:www-data /data/stitched

# ensure cron has same environmental variables
printenv | grep -v "no_proxy" >> /etc/environment

# test and update crontab on container start/restart
if [ -f /data/sync_cron ]; then
    echo "Custom crontab found, updating crontab."
    crontab /data/sync_cron
else
    echo "Custom crontab does not exist, skipping crontab update."
fi

cron -f
