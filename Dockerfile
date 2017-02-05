FROM resin/armhf-alpine:3.4

RUN [ "cross-build-start" ]

MAINTAINER Péter Szilágyi <peterke@gmail.com>

RUN \
  apk add --update ca-certificates go git musl-dev && \
	mkdir /work && export GOPATH=/work               && \
	\
	go get github.com/karalabe/cloudflare-dyndns      && \
	cp /work/bin/cloudflare-dyndns /cloudflare-dyndns && \
	\
  apk del go git musl-dev && \
  rm -rf /work && rm -rf /var/cache/apk/*

RUN [ "cross-build-end" ]

ENTRYPOINT ["/cloudflare-dyndns"]
