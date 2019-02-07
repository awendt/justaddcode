#!/usr/bin/env bash

curl -L https://packagecloud.io/dokku/dokku/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ bionic main" > /etc/apt/sources.list.d/dokku_dokku.list
