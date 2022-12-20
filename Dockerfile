FROM golang:1.19 as builder
COPY ./ .
RUN CGO_ENABLED=0 GOOS=linux go build

FROM edenhill/kafkacat:1.6.0
RUN apt-get update && apt-get install -y jq
COPY ./ .
COPY --from=builder /httpstdin /usr/src/httpstdin
RUN chmod +x run.sh 
ENTRYPOINT ["/run.sh"]
EXPOSE 8080
