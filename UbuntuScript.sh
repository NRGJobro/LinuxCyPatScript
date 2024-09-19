#!/bin/bash

# update system
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get dist-upgrade

# delete users
#sudo userdel -r [USER]

# remove admin perms
#sudo deluser [USER] sudo

# change user password
#sudo passwd [USER]

# secure root
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh reload

# enfore password reqs
sudo sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs
sudo sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_DAYS    7/' /etc/login.defs
sudo sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE    14/' /etc/login.defs

# enable firewall
sudo ufw enable

# sudo sed -i 'pam_unix.so/s/$/ minlen=8 remember=5' /etc/pam.d/common-password 
