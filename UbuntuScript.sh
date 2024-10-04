#!/bin/bash

# update system
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install clamtk -y	

# search for prohibited files
#sudo find / -name “*.{extension}” –type f

# change user passwords
echo [USER1]:Cyb3rPatr!0t$ >> pass.txt
echo [USER2]:Cyb3rPatr!0t$ >> pass.txt
echo [USER3]:Cyb3rPatr!0t$ >> pass.txt
echo [USER4]:Cyb3rPatr!0t$ >> pass.txt
echo [USER5]:Cyb3rPatr!0t$ >> pass.txt
sudo chpasswd < pass.txt

# secure root
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh reload

# disable guest user
#sudo sed -i 'aallow-guest=false' /etc/lightdm/lightdm.conf
#sudo restart lightdm

# enfore password reqs
sudo sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS    90/' /etc/login.defs
sudo sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_DAYS    7/' /etc/login.defs
sudo sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE    14/' /etc/login.defs

# min password length and password history
sudo sed -i '/pam_unix.so/ s/$/ minlen=8 remember=5/' /etc/pam.d/common-password

# null passwords do not authenticate
sudo sed -i 's/nullok/ /g' /etc/pam.d/common-auth

# remove bad services
sudo systemctl stop nginx 
sudo systemctl disable nginx 
sudo apt-get purge netcat -y -qq
sudo apt-get purge netcat-openbsd -y -qq
sudo apt-get purge netcat-traditional -y -qq
sudo apt-get purge ncat -y -qq
sudo apt-get purge pnetcat -y -qq
sudo apt-get purge socat -y -qq
sudo apt-get purge sock -y -qq
sudo apt-get purge socket -y -qq
sudo apt-get purge sbd -y -qq
sudo apt-get purge hydra -y -qq
sudo apt-get purge hydra-gtk -y -qq
sudo apt-get purge john -y -qq
sudo apt-get purge john-data -y -qq
sudo apt-get purge aircrack-ng -y -qq
sudo apt-get purge fcrackzip -y -qq
sudo apt-get purge lcrack -y -qq
sudo apt-get purge ophcrack -y -qq
sudo apt-get purge ophcrack-cli -y -qq
sudo apt-get purge pdfcrack -y -qq
sudo apt-get purge pyrit -y -qq
sudo apt-get purge rarcrack -y -qq
sudo apt-get purge sipcrack -y -qq
sudo apt-get purge irpas -y -qq

# enable firewall
sudo ufw enable
