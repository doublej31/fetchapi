FROM golang:1.10

COPY . /go/src/github.com/fetchapi

RUN go install github.com/fetchapi/cmd/server