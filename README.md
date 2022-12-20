# httpstdin

```
docker build -t kafka-message-export .
docker run -d kafka-message-export --name metrics -p 8080:8080
```
web:
`http://127.0.0.1:8080/metrics`
