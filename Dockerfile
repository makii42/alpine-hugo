FROM alpine:latest

ENV HUGO_VERSION 0.31.1
ENV HUGO_DIR /usr/local/lib

RUN apk add --no-cache curl nginx && \
  rm /etc/nginx/conf.d/default.conf && \
  curl -o /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -sSL \
  https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xz -C ${HUGO_DIR} -f /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  ln -sf ${HUGO_DIR}/hugo_0.18.1_linux_amd64/hugo_0.18.1_linux_amd64 /usr/local/bin/hugo && \
  rm /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  mkdir -p /site /run/nginx && \
  apk del --no-cache curl

ADD hugo.nginx.conf /etc/nginx/conf.d/hugo.conf
RUN /usr/sbin/nginx -t

WORKDIR /site
ONBUILD ADD . /site/
ONBUILD RUN hugo

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
