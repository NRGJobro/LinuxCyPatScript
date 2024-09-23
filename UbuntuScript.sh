#!/bin/bash

# update system
sudo apt-get update 
sudo apt-get upgrade 
sudo apt-get dist-upgrade

# change user password
#sudo passwd [USER]

# secure root
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh reload

# enfore password reqs
sudo sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs
sudo sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_DAYS    7/' /etc/login.defs
sudo sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE    14/' /etc/login.defs

# min password length and password history
sudo sed -i '/pam_unix.so/ s/$/ minlen=8 remember=5/' /etc/pam.d/common-password

# enable firewall
sudo ufw enable

##### uncomment if on mint
# disable guest user
#sudo sed -i 'aallow-guest=false' /etc/lightdm/lightdm.conf
