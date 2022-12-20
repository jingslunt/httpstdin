# kafka-message-export

```
docker build -t kafka-message-export .
docker run -d kafka-message-export --name kafka-message-export -p 8080:8080
```
web:
`http://127.0.0.1:8080/metrics`

注：
httpstdin 使用标准输入作为http返回，支持管道。很多时候需要配合xargs使用
