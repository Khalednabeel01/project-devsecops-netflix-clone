# 🎬 Netflix Clone CI/CD Pipeline with DevSecOps & Monitoring

A complete **DevSecOps CI/CD Pipeline Project** for deploying a **Netflix Clone Application** using modern DevOps tools and practices.  
This project demonstrates automated build, security scanning, containerization, deployment, and monitoring using Jenkins, Docker, SonarQube, Trivy, Prometheus, and Grafana.

---

# 🚀 Project Overview

This project automates the deployment lifecycle of a Netflix Clone application using a full CI/CD pipeline.

The pipeline includes:

- Continuous Integration with Jenkins
- Code Quality Analysis using SonarQube
- Vulnerability Scanning using Trivy & OWASP Dependency Check
- Docker Image Build & Deployment
- Monitoring with Prometheus & Grafana
- Email Notifications
- Secure DevSecOps Workflow

---

# 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Jenkins | CI/CD Automation |
| Docker | Containerization |
| SonarQube | Static Code Analysis |
| Trivy | Vulnerability Scanning |
| OWASP Dependency Check | Dependency Security Scan |
| Prometheus | Metrics Collection |
| Grafana | Monitoring Dashboard |
| Node Exporter | System Metrics |
| AWS EC2 | Cloud Infrastructure |
| TMDB API | Movie Data API |

---

# 📌 Architecture Diagram

```text
Developer
   │
   ▼
GitHub Repository
   │
   ▼
Jenkins Pipeline
   ├── Build Application
   ├── SonarQube Analysis
   ├── OWASP Dependency Check
   ├── Trivy Scan
   ├── Docker Build
   ├── Docker Push
   └── Deployment
            │
            ▼
      Docker Container
            │
            ▼
Monitoring Stack
(Prometheus + Grafana + Node Exporter)
```

---

# ⚙️ Project Setup

## 1️⃣ Launch AWS EC2 Instances

### Jenkins Server
- Ubuntu 24.04
- Instance Type: m7i-flex.large

### Monitoring Server
- Ubuntu 24.04
- Instance Type: t3.small

---

# 🔧 Jenkins Installation

## Install Java & Jenkins

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

---

# 🐳 Docker Installation

```bash
sudo apt-get update

sudo apt-get install docker.io -y

sudo usermod -aG docker $USER

newgrp docker

sudo chmod 777 /var/run/docker.sock
```

---

# 🔍 SonarQube Setup

## Run SonarQube Container

```bash
docker run -d --name sonar -p 9000:9000 sonarqube:community
```

### Default Credentials

```text
Username: admin
Password: admin
```

---

# 🔐 Security Tools

## Install Trivy

```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt-get update

sudo apt-get install trivy -y
```

---

# 📊 Monitoring Setup

## Install Prometheus

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz

tar -xvf prometheus-2.47.1.linux-amd64.tar.gz
```

---

## Install Node Exporter

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz
```

---

## Install Grafana

```bash
sudo apt-get install -y apt-transport-https software-properties-common

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update

sudo apt-get install grafana -y
```

---

# 📈 Grafana Dashboards

### Node Exporter Dashboard
```text
Dashboard ID: 1860
```

### Jenkins Monitoring Dashboard
```text
Dashboard ID: 9964
```

---

# 🔌 Jenkins Plugins Used

- Eclipse Temurin Installer
- SonarQube Scanner
- NodeJS Plugin
- OWASP Dependency Check
- Docker Plugins
- Prometheus Metrics Plugin
- Email Extension Plugin

---

# 🔄 CI/CD Pipeline Flow

```text
1. Developer pushes code to GitHub
2. Jenkins triggers pipeline
3. Source code checkout
4. Install dependencies
5. SonarQube code analysis
6. OWASP dependency scanning
7. Trivy vulnerability scanning
8. Docker image build
9. Push image to DockerHub
10. Deploy container
11. Monitoring & alerting
12. Email notification
```

---

# 🧪 Pipeline Features

✅ Automated CI/CD Pipeline  
✅ DevSecOps Integration  
✅ Static Code Analysis  
✅ Dependency Vulnerability Scan  
✅ Container Vulnerability Scan  
✅ Dockerized Deployment  
✅ Monitoring & Visualization  
✅ Jenkins Email Notifications  
✅ Scalable Cloud Deployment  

---

# 📂 Project Structure

```text
├── scripts/                        # Automation & Installation Scripts
│   ├── jenkins.sh                  # Jenkins Installation Script
│   ├── trivy.sh                    # Trivy Installation Script
│
├── monitoring/                     # Monitoring & Metrics Configuration
│   ├── prometheus.yml              # Prometheus Configuration File
│   ├── prometheus.service          # Prometheus Systemd Service
│   ├── node_exporter.service       # Node Exporter Systemd Service
│   └── grafana/                    # Grafana Dashboard Configurations
│
├── security/                       # DevSecOps & Security Scanning
│   ├── trivy/                      # Trivy Scan Reports
│   ├── dependency-check/           # OWASP Dependency Check Reports
│   └── sonarqube/                  # SonarQube Analysis Reports
```

---

# 🌐 Access Services

| Service | Port |
|---|---|
| Jenkins | 8080 |
| SonarQube | 9000 |
| Prometheus | 9090 |
| Grafana | 3000 |
| Netflix App | Custom Port |

---

# 📸 Screenshots

You can add screenshots for:
<img width="1352" height="611" alt="netflix" src="https://github.com/user-attachments/assets/bc90c07f-c5a2-4048-89d1-8af951b5d22b" />
<img width="1354" height="600" alt="Grafana" src="https://github.com/user-attachments/assets/ca6e302e-a1fe-491c-ae2f-7581a3015cfd" />
<img width="1366" height="580" alt="sonarQube" src="https://github.com/user-attachments/assets/37054e92-18a4-411b-9490-720f509bdb3e" />
<img width="1359" height="565" alt="Pipline" src="https://github.com/user-attachments/assets/6247147d-37c0-43cc-ab9d-e79f635c7a9d" />

---

# 🏆 Learning Outcomes

Through this project, I learned:

- Building end-to-end CI/CD pipelines
- Implementing DevSecOps practices
- Containerized deployments with Docker
- Infrastructure monitoring using Prometheus & Grafana
- Security scanning and vulnerability management
- Jenkins automation and integrations

---

# 🤝 Connect With Me

## 👨‍💻 Author

**Khaled Nabil**

- GitHub: https://github.com/Khalednabeel01
- LinkedIn: https://www.linkedin.com/in/khaled-nabeel-5b780513a/

---
