ARG CONFIG_TAG=latest
FROM koinos/koinos-chain:${CONFIG_TAG} as chain

FROM alpine:latest
RUN apk update && \
    apk add rsync \
            bash \
            musl \
            libstdc++

ADD . /koinos-config
COPY --from=chain /usr/local/bin/koinos_get_dev_key /usr/local/bin

CMD [ "bash", "/koinos-config/run.sh" ]
