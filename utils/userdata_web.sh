#!/bin/bash
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl status amazon-ssm-agent
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo amazon-linux-extras install epel -y
sudo sed -i 's/RPM-GPG-KEY-mysql/RPM-GPG-KEY-mysql-2022/g' /etc/yum.repos.d/mysql-community.repo
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y mysql-community-client
# noip
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y noip
sudo noip2 -C
sudo systemctl enable noip.service
sudo systemctl start noip.service