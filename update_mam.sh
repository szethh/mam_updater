#!/bin/bash

# adapted from https://github.com/qdm12/gluetun/issues/1785#issuecomment-1944451745

# store the last known public IP address
ip_file="/data/ip"
current_ip=$(curl -s ipinfo.io/ip)

echo "[$(date '+%Y-%m-%d %H:%M:%S')] MAM updater starting. IP=$current_ip"

# Check if the IP has changed
if [ ! -f "$ip_file" ] || [ "$(cat "$ip_file")" != "$current_ip" ]; then
    echo "$current_ip" > "$ip_file"

    echo "IP changed since last run. Updating MAM..."
    
    response = $(curl -c /data/mam.cookies -b /data/mam.cookies https://t.myanonamouse.net/json/dynamicSeedbox.php)
    echo "$response"
else
    echo "IP is unchanged: $current_ip. No action taken"
fi