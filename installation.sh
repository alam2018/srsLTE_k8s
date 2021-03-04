#!/bin/bash

#install docker-compose
sudo apt-get install docker-compose

echo " "
echo "Container cooking started"
echo "========================"
echo " "
sudo docker-compose up -d

echo " "
echo "Allowing container communication in IPtables"
echo "============================================="
echo " "
sudo iptables -I FORWARD 1 -j ACCEPT
sudo iptables-save
