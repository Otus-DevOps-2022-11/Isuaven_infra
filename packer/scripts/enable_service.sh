#!/bin/sh
mv /tmp/puma.service /etc/systemd/system/puma.service
chown root:root /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma.service
