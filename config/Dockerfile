FROM alpine:latest
RUN apk update && \
    apk add rsync

ADD . /koinos-config

CMD rsync -a -v --ignore-existing /koinos-config/default-config.yml /koinos/config.yml
