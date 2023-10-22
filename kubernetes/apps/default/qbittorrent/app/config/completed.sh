#!/bin/bash
# qBittorrent settings > 'Run external program on torrent finished'
# /scripts/completed.sh "%F" "%G"
/bin/chmod -R 750 "$1"
if [[ "$2" == *"skip-cross-seed"* ]]; then
    printf "Skipping cross-seed check for '%s' with tags '%s'\n" "$1" "$2"
else
    printf "Searching cross-seed for '%s' with tags '%s'\n" "$1" "$2"
    /usr/bin/curl \
        --silent \
        --connect-timeout 5 \
        --max-time 10 \
        --retry 5 \
        --retry-delay 0 \
        --retry-max-time 40 \
        --request POST \
        --data-urlencode "path=$1" \
        http://cross-seed.default.svc.cluster.local:2468/api/webhook
fi
exit 0