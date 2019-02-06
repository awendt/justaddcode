#!/usr/bin/env bash

curl -L https://packagecloud.io/dokku/dokku/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" > /etc/apt/sources.list.d/dokku_dokku.list
