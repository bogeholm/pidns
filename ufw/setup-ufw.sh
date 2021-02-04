#! /usr/bin/env bash

set -x

# Defaults
ufw default deny incoming
ufw default allow outgoing

# SSH
ufw allow proto tcp from 192.168.3.0/24 to any port 22
ufw allow proto tcp from 192.168.9.0/24 to any port 22

# HTTP / HTTPS
ufw allow proto tcp from 192.168.3.0/24 to any port 80,443
ufw allow proto tcp from 192.168.9.0/24 to any port 80,443

# DNS - equivalent to
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
