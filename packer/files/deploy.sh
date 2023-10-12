#!/bin/bash
sudo apt update
sudo apt install git-all -y
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

sudo mv /home/ubuntu/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
