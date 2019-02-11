#!/usr/bin/env bash

dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku ssh-keys:add root ~/.ssh/authorized_keys
