#!/usr/bin/env bash

dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
cat ~/.ssh/authorized_keys >> ~dokku/.ssh/authorized_keys
