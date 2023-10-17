#!/bin/bash
set -e
sudo rm /etc/mongod.conf
sudo cp -f /tmp/mongod.conf /etc/mongod.conf
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo service mongod restart
