#!/bin/sh
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add - # После пайпа sudo не убрано - а то не отработает добавление ключа
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update -y
sleep 80
apt-get install -y mongodb-org
systemctl enable mongod
systemctl start mongod
