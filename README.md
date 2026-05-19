# 🎬 Netflix Clone — Full CI/CD Pipeline with DevSecOps

A production-grade deployment of a Netflix clone application using a complete DevSecOps pipeline — featuring automated builds,
security scanning, code quality analysis, containerized deployment, and real-time monitoring.

---

## 📐 Architecture Overview

```
GitHub  ──►  Jenkins  ──►  SonarQube Analysis
                │
                ├──►  OWASP Dependency Check
                ├──►  Trivy File System Scan
                ├──►  Docker Build & Push (DockerHub)
                ├──►  Trivy Image Scan
                └──►  Deploy on Docker Container
                           │
                     Prometheus + Grafana
                       (Monitoring Layer)
```

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| **CI/CD** | Jenkins |
| **Containerization** | Docker |
| **Code Quality** | SonarQube |
| **Security Scanning** | Trivy, OWASP Dependency Check |
| **Monitoring** | Prometheus, Grafana, Node Exporter |
| **Runtime** | Node.js 26 |
| **JDK** | Eclipse Temurin 21 |
| **Cloud** | AWS EC2 (Ubuntu 24.04) |
| **Movie Data API** | TMDB (The Movie Database) |
| **Notifications** | Jenkins Email Plugin (SMTP / Gmail) |

---

## 🚀 Pipeline Stages

```
Declarative Tool Install  →  Clean Workspace  →  Checkout from Git
→  SonarQube Analysis  →  Quality Gate  →  Install Dependencies
→  OWASP FS Scan  →  Trivy FS Scan  →  Docker Build & Push
→  Trivy Image Scan  →  Deploy to Container  →  Post Actions (Email)
```

All stages completed with an average full run time of **~5 minutes**.

---

## ⚙️ Infrastructure Setup

### Server 1 — Jenkins Server (m7i-flex.large)
- Jenkins + JDK 21
- Docker + SonarQube container (port `9000`)
- Trivy
- All required Jenkins plugins

### Server 2 — Monitoring Server (t3.small)
- Prometheus (port `9090`)
- Node Exporter (port `9100`)
- Grafana (port `3000`)

---

## 🔌 Jenkins Plugins Installed

- Eclipse Temurin Installer
- SonarQube Scanner
- NodeJS Plugin
- OWASP Dependency-Check
- Docker, Docker Commons, Docker Pipeline, Docker API, docker-build-step
- Prometheus Metrics
- Email Extension Plugin

---

## 📊 Monitoring & Dashboards

Prometheus scrapes metrics from three targets:

| Target | Port | Dashboard ID |
|---|---|---|
| Prometheus (self) | `9090` | — |
| Node Exporter | `9100` | `1860` |
| Jenkins | `8080/prometheus` | `9964` |

Grafana dashboards provide real-time visibility into CPU, memory, disk I/O, JVM usage, Jenkins build health, and more.

---

## 🔐 Security Scanning

- **Trivy** — filesystem scan before build, image scan after push
- **OWASP Dependency Check** — scans Node.js dependencies for known CVEs
- **SonarQube** — static code analysis with quality gate enforcement

Trivy scan results (`trivyfs.txt`) and build logs are automatically attached to the pipeline notification email.

---

## 📧 Notifications

Jenkins sends an email notification on pipeline completion (success or failure) including:
- Project name & build number
- Build URL
- Attachments: `trivyfs.txt` + `build.log`

---

## 📁 Pipeline Script

The full Jenkinsfile / pipeline script is available here:
👉 [Pipeline Script on GitHub](https://github.com/Khalednabeel01/project-devsecops-netflix-clone.git)

---


| Jenkins Pipeline | Netflix App | Grafana Dashboard |

| All stages green ✅ | Accessible on browser ✅ | Node Exporter & Jenkins metrics ✅ |

---

## 📝 Prerequisites

- AWS account with EC2 access
- DockerHub account
- TMDB API key (free at [themoviedb.org](https://www.themoviedb.org))
- Gmail account with App Password enabled (for SMTP notifications)

---

## 🙌 Acknowledgements

Project inspired by real-world DevSecOps pipelines. Tools used are all open-source or free-tier.

---
