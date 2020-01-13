#based on /alpine-sshd/dockerfile and others
FROM alpine:latest
MAINTAINER Martin Pichlo <m.pichlo@gmx.de>
ADD entrypoint.sh /usr/local/bin

RUN apk add --update openssh && rm  -rf /tmp/* /var/cache/apk/* && \
    rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && \
    cat > /etc/motd

EXPOSE 22
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

