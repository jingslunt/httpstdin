FROM edenhill/kafkacat:1.6.0
RUN apt-get update && apt-get install -y jq
RUN go build && chmod +x /httpstdin/run.sh 
ENTRYPOINT ["/httpstdin/run.sh"]
