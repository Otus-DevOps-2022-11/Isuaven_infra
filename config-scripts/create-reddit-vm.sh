#!/bin/bash
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH

yc compute instance create \
  --name reddit-full-$(date +%s) \
  --hostname reddit-full \
  --memory=4 \
  --create-boot-disk image-id="fd8pfvpb19e1f481ch4o",size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --zone ru-central1-a \
  --ssh-key ~/.ssh/appuser.pub
