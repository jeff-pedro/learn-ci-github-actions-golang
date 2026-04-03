FROM golang:1.22
WORKDIR /app
COPY . .
ENTRYPOINT ["go", "run", "main.go"]
