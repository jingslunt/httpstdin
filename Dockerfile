FROM edenhill/kafkacat:1.6.0
RUN apt-get update && apt-get install -y jq
COPY run.sh .
RUN go build && chmod +x run.sh 
ENTRYPOINT ["/run.sh"]
