#!/bin/bash

fallocate -l 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
