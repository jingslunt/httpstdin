FROM golang:1.19 as builder
COPY ./ .
RUN CGO_ENABLED=0 GOOS=linux go build -o /httpstdin main.go

FROM edenhill/kafkacat:1.6.0
WORKDIR /
RUN apk add --no-cache jq
COPY ./ .
COPY --from=builder /httpstdin /usr/bin/httpstdin
ENTRYPOINT ["kafkacat"]
CMD ["-b", "10.238.239.200:9092", "-t", "mp-biz", "-G", "logstash", "-p", "0", "-C", "|jq", "-r", "-c", "'{level,scenario,appName}|select(.level==\"ERROR\")'|", "grep", "-oP", "'^\\s*(\\{(?:[^{}]|(?1))*\\})\\s*$'", "|awk", "'{count[$1]++}END", "{for", "(minute", "in", "count)", "print", "\"logs_error\"minute,count[minute]}'","|httpstdin"]
EXPOSE 8080
