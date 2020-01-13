#!/bin/sh

# generate all host keys if not present
if [ ! -f "ssh_host_ecdsa_key.pub" ]; then
	ssh-keygen -A
fi

# setup logon methods
if [ ! -f "/etc/ssh/sshd_config_org" ]; then

	# sshd config
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config_org
	sed -i "s/#PermitRootLogin.*/PermitRootLogin prohibit-password/" /etc/ssh/sshd_config
	sed -i "s/#PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config
	sed -i "s/GatewayPorts.*/GatewayPorts yes/" /etc/ssh/sshd_config
	sed -i "s/#ClientAliveInterval.*/ClientAliveInterval 10/" /etc/ssh/sshd_config

	# unlock root user
	passwd -u root
fi

# prepare run dir
if [ ! -d "/var/run/sshd" ]; then
	mkdir -p /var/run/sshd
fi

exec "$@"
