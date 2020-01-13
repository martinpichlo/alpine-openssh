FROM alpine:latest
###MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>

# add openssh and clean
RUN apk add --update openssh \
&& rm  -rf /tmp/* /var/cache/apk/*
# add entrypoint script
ADD entrypoint.sh /usr/local/bin
#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

EXPOSE 22
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

