#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# set root login mode by password or keypair
if [ "${KEYPAIR_LOGIN}" = "true" ] && [ -f "${HOME}/.ssh/authorized_keys" ] ; then
    sed -i "s/PermitRootLogin.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
    sed -i "s/#PermitRootLogin.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
    sed -i "s/PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication no/" /etc/ssh/sshd_config
    sed -i "s/GatewayPorts.*/GatewayPorts yes/" /etc/ssh/sshd_config
    sed -i "s/#GatewayPorts.*/GatewayPorts yes/" /etc/ssh/sshd_config
    sed -i "s/ClientAliveInterval.*/ClientAliveInterval 10/" /etc/ssh/sshd_config
    sed -i "s/#ClientAliveInterval.*/ClientAliveInterval 10/" /etc/ssh/sshd_config
    echo "Enabled root-login by keypair and disabled password-login"
else
    sed -i "s/PermitRootLogin.*/PermitRootLogin\ yes/" /etc/ssh/sshd_config
    sed -i "s/GatewayPorts.*/GatewayPorts yes/" /etc/ssh/sshd_config
    sed -i "s/ClientAliveInterval.*/ClientAliveInterval 10/" /etc/ssh/sshd_config
    sed -i "s/PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config
    sed -i "s/#PermitRootLogin.*/PermitRootLogin\ yes/" /etc/ssh/sshd_config
    sed -i "s/#GatewayPorts.*/GatewayPorts yes/" /etc/ssh/sshd_config
    sed -i "s/#ClientAliveInterval.*/ClientAliveInterval 10/" /etc/ssh/sshd_config
    if [ -n "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
        echo "root:${ROOT_PASSWORD}" | chpasswd
    fi
    echo "Enabled root-login by password"
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
