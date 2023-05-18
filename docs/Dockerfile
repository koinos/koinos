FROM python:3.11-alpine as builder

RUN pip install \
        mkdocs \
        mkdocs-material

ADD . /build
WORKDIR /build

RUN mkdocs build

FROM httpd:2.4-alpine
COPY --from=builder /build/site/ /usr/local/apache2/htdocs/
COPY scripts /usr/local/bin/
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

ENTRYPOINT [ "/usr/local/bin/start" ]