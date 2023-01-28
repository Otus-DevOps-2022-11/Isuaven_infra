#!/bin/bash

sudo mv -f /tmp/mongod.conf /etc/mongod.conf
sudo systemctl restart mongod
