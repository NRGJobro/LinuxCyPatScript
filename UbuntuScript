#!/bin/bash

# update system
apt-get update 
apt-get upgrade 
apt-get dist-upgrade

# secure root
sed -i 's/PermitRootLogin yes/PermitRootLogin no' /etc/ssh/sshd_config
