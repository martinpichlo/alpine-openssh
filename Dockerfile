FROM alpine:3.7
ENV KEYPAIR_LOGIN=false ROOT_PASSWORD=root

ADD entrypoint.sh /
RUN apk update && apk upgrade && apk add openssh && chmod +x /entrypoint.sh && mkdir -p /root/.ssh && rm -rf /var/cache/apk/* /tmp/*

EXPOSE 22
VOLUME ["/etc/ssh"]
ENTRYPOINT ["/entrypoint.sh“]
