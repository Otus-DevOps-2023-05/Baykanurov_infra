#!/bin/sh
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update -y
sleep 80
apt-get install -y ruby-full ruby-bundler build-essential
