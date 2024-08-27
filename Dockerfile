FROM golang:1.23 AS builder

WORKDIR /usr/src/app

COPY main.go ./

RUN go mod init fullcycle-world || true
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o fullcycle

FROM scratch

COPY --from=builder /usr/src/app/fullcycle /
EXPOSE 8080

CMD ["/fullcycle"]
