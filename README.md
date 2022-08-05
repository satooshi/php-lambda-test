# php-lambda-test

To build:

```
docker build -t phpmyfunction .
docker run -p 9000:8080 phpmyfunction:latest
```

To test:

```
curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"queryStringParameters": {"name":"Ben"}}'
```
