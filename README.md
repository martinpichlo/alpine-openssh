# docker-openssh
Docker OpenSSH for Autossh

## docker-compose

	version: "3.7"
	
	services:
	
	  ssh:
	    image: zeaq/alpine-openssh
	    build: alpine-openssh
	    hostname: ssh
	    container_name: ssh
	    network_mode: bridge
	    restart: always
	    ports:
          - "23:22"
          - "24:24"
	    volumes:
	      - /home/martin/ssh/authorized_keys:/root/.ssh/authorized_keys
	    environment:
	      - LogLevel=DEBUG

