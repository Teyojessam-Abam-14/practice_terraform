#!/bin/bash
sudo su -
yum update -y
yum install git -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd mariadb-server
yum install -y nfs-utils
systemctl start httpd
systemctl enable httpd
systemctl is-enabled httpd

