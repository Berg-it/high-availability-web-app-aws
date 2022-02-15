#!/bin/bash
sudo su
yum check-update
echo "install nginx"
yum install -y httpd
chkconfig httpd on
echo "<h1><b1>Hello Guys</b1><h1>" > /var/www/html/index.html
service httpd start 