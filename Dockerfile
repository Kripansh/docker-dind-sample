####--------------
FROM golang:1.17.8-alpine3.15  AS build-env

RUN apk add --no-cache git gcc musl-dev
RUN apk add --update make

FROM docker:20.10.17-dind
# All these steps will be cached
#RUN apk add --no-cache ca-certificates
RUN apk update && apk add --no-cache --virtual .build-deps && apk add bash && apk add make && apk add curl && apk add openssh && apk add git && apk add zip
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN apk -Uuv add groff less python3 py3-pip
RUN pip3 install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*
COPY --from=docker/compose:latest /usr/local/bin/docker-compose /usr/bin/docker-compose

