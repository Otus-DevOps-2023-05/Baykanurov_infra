#!/bin/bash

sudo apt update -y && \
sudo apt install git-all -y

git clone -b monolith https://github.com/express42/reddit.git

cd reddit && \
bundle install

puma -d
ps aux | grep puma

