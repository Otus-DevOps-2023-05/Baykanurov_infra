#!/bin/bash

sudo apt update -y && \
sudo apt install ruby-full ruby-bundler build-essential -y

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodborg/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

sudo apt-get update -y && \
sudo apt-get install mongodb-org -y

sudo systemctl start mongod && \
sudo systemctl enable mongod && \
sudo systemctl status mongod

sudo apt update -y && \
sudo apt install git-all -y

git clone -b monolith https://github.com/express42/reddit.git

cd reddit && \
bundle install

puma -d
ps aux | grep puma
