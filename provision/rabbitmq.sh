#!/bin/bash

sudo yum update -y
sudo yum install epel-release -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash

sudo yum clean all
sudo yum makecache
sudo yum install erlang -y
cd /tmp
$ wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.34/rabbitmq-server-3.8.34-1.el8.noarch.rpm
sudo yum -y install rabbitmq-server-3.8.34-1.el8.noarch.rpm


sudo systemctl start rabbitmq-server 
sudo systemctl enable rabbitmq-server 
sudo systemctl status rabbitmq-server

sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server


sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=25672/tcp --permanent
sudo firewall-cmd --reload
