#based on /alpine-sshd/dockerfile and others
FROM alpine:latest
MAINTAINER Martin Pichlo <m.pichlo@gmx.de>

# add openssh and clean
RUN apk add --update openssh \
&& rm  -rf /tmp/* /var/cache/apk/*
# add entrypoint script
ADD entrypoint.sh /usr/local/bin
#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

#inherit permissions
#VOLUME /root/.ssh

EXPOSE 22
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

