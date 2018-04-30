#使用ubuntu 16.04

#! /bin/bash
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# 注意
# 注意，我這邊有特別開對外listen的port，這邊如果不是在private subnet底下的話會很危險
# 注意
sed -i "s/ExecStart=\/usr\/bin\/dockerd -H fd:\/\//ExecStart=\/usr\/bin\/dockerd -H fd:\/\/ -H tcp:\/\/0.0.0.0:2375/g" /lib/systemd/system/docker.service
systemctl daemon-reload
service docker restart
