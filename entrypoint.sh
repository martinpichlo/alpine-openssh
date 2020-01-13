#!/bin/sh

# generate fresh rsa key
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

# generate fresh dsa key
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

#prepare config
if [ ! -f "/etc/ssh/sshd_config_org" ]; then
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config_org
# sed -i "s/#PermitRootLogin.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
# sed -i "s/#PermitRootLogin.*/PermitRootLogin prohibit-password/" /etc/ssh/sshd_config
# sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
  sed -i "s/GatewayPorts no/GatewayPorts yes/" /etc/ssh/sshd_config
  sed -i "s/#ClientAliveInterval 0/ClientAliveInterval 10/" /etc/ssh/sshd_config
fi

#workarround
if [ ! -f "/root/.ssh/authorized_keys" ]; then
  cp /root/.ssh/authorized_keys_org /root/.ssh/authorized_keys
  chown root:root /root/.ssh/authorized_keys
fi

exec "$@"
