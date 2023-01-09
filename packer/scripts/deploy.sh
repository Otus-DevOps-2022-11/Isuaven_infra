#!/bin/sh
mkdir -p /home/project/
cd /home/project/
apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
