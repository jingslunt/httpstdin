#!/bin/bash
kafkacat -b 10.238.239.200:9092 -t mp-biz -G logstash -p 0   -C \
|jq -r -c '{level,scenario,appName}|select(.level=="ERROR")' \
| grep -oP '^\s*(\{(?:[^{}]|(?1))*\})\s*$' \
|awk  '{count[$1]++}END {for (minute in count) print "logs_error"minute,count[minute]}' \
|httpstdin
