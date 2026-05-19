#!/bin/bash

set -e

echo "====================================="
echo " Updating Ubuntu Packages"
echo "====================================="

sudo apt update -y
sudo apt upgrade -y

echo "====================================="
echo " Installing Required Packages"
echo "====================================="

sudo apt install -y \
openjdk-21-jdk \
curl \
wget \
gnupg \
ca-certificates \
fontconfig

echo "====================================="
echo " Java Version"
echo "====================================="

java -version

echo "====================================="
echo " Removing Old Jenkins Configs"
echo "====================================="

sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins-keyring.gpg
sudo rm -rf /var/lib/apt/lists/*

echo "====================================="
echo " Downloading Jenkins Latest Stable"
echo "====================================="

wget https://get.jenkins.io/debian-stable/latest/jenkins.io.key

echo "====================================="
echo " Adding Jenkins Repository"
echo "====================================="

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "====================================="
echo " Updating Package Lists"
echo "====================================="

sudo apt update -y || true

echo "====================================="
echo " Installing Jenkins"
echo "====================================="

sudo apt install -y jenkins --allow-unauthenticated

echo "====================================="
echo " Starting Jenkins"
echo "====================================="

sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl restart jenkins

echo "====================================="
echo " Jenkins Status"
echo "====================================="

sudo systemctl status jenkins --no-pager

echo "====================================="
echo " Jenkins Version"
echo "====================================="

jenkins --version || true

echo "====================================="
echo " Initial Admin Password"
echo "====================================="

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "====================================="
echo " DONE"
echo " Access Jenkins:"
echo " http://YOUR_EC2_PUBLIC_IP:8080"
echo "====================================="
