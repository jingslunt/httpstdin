FROM golang:1.19 as builder
COPY ./ .
RUN CGO_ENABLED=0 GOOS=linux go build -o /httpstdin main.go

FROM edenhill/kafkacat:1.6.0
WORKDIR /
RUN apk add --no-cache jq
COPY ./ .
COPY --from=builder /httpstdin /usr/bin/httpstdin
RUN chmod +x run.sh 
ENTRYPOINT ["/run.sh"]
EXPOSE 8080
