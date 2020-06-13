FROM golang:1.14-buster as build

WORKDIR /go/src/app
ADD . /go/src/app

RUN    cd cmd/rabtap \
    && VERSION=$(git describe --tags) \
    && CGO_ENABLED=0 \
       go build -ldflags "-s -w -X main.RabtapAppVersion=$VERSION" -o /go/bin/rabtap


FROM alpine:3.8
LABEL maintainer="Jan Delgado <jdelgado@gmx.net>"

COPY --from=build /go/bin/rabtap /bin
CMD ["/bin/rabtap"]

