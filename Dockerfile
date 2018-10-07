FROM golang:latest AS BUILDER

ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

WORKDIR /go/src/github.com/fetchapi
COPY . .

RUN dep ensure --vendor-only -v

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main github.com/fetchapi/cmd/server

# user apline as runner to create smaller image
FROM alpine
WORKDIR /root/
COPY --from=builder go/src/github.com/fetchapi .

# Set environment variables for application
ENV PORT=8080

EXPOSE 8080
CMD [ "./main" ]