#!/bin/bash

echo "Updating packages..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

echo "Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | \
sudo tee /etc/apt/sources.list.d/trivy.list

echo "Updating repositories..."
sudo apt-get update -y

echo "Installing Trivy..."
sudo apt-get install trivy -y

echo "Checking Trivy version..."
trivy --version

echo "Trivy installed successfully!"
