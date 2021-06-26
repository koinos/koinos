FROM koinos/koinos-chain:latest as chain

FROM alpine:latest
RUN apk update && \
    apk add rsync \
            bash \
            musl \
            libstdc++

ADD . /koinos-config
COPY --from=chain /usr/local/bin/koinos_get_dev_key /usr/local/bin

CMD [ "bash", "/koinos-config/run.sh" ]
