# httpstdin

```
docker build -t httpstdin .
docker run -d httpstdin --name metrics -p 8080:8080
```
web:
`http://127.0.0.1:8080/metrics`
