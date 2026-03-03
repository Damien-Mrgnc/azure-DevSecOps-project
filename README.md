# DevSecOps Enterprise Cloud Project (Azure & GitHub Actions)

Welcome to the DevSecOps cloud industrialization project. This repository transforms a basic web application and infrastructure into a highly resilient, automated, and secure DevSecOps factory. 

The architecture encompasses the entire lifecycle, from code commit (Node.js) to Infrastructure provisioning (Terraform) down to continuous Azure deployment and dynamic security compliance scanning.

*Read the [French Version (Version Française)](README_FR.md) here.*

## 🚀 Project Phases
This project is deeply documented and structured logically into progressive DevSecOps capability phases:

### [Phase 0: Initialization](./phase-0-initialisation/README.md)
Repository bootstrapping, environments setup, and initial OIDC connection between GitHub Actions and Microsoft Azure to avoid manipulating static secrets.

### [Phase 1: Continuous Integration (App)](./phase-1-ci-app/README.md)
Securing and building the application source code.
- Node.js Linting & Unit Testing
- Pre-merge static code scanning (SAST with SonarCloud)
- Docker Image Build & Push to Azure Container Registry (ACR)
- Container Vulnerability Scanning (Trivy)
- Cryptographic code signing of built containers (Cosign/Sigstore)

### [Phase 2: Continuous Integration (Infra)](./phase-2-ci-infra/README.md)
Validating and securing Infrastructure as Code (Terraform).
- Code formatting and syntax validation (`terraform fmt`/`validate`)
- Infrastructure Security Scanning (Checkov IaC scanning)
- Dry-run Plan generation over real Azure states (`terraform plan`)

### [Phase 3: Continuous Deployment (CD)](./phase-3-cd/README.md)
Automating safe software delivery over Azure App Services.
- Headless infrastructure deployments (`terraform apply`)
- Container Registry hooking mapping App Services to newly pushed Images
- Automated dynamic runtime health checks 

### [Phase 4: Dynamic Security Testing (DAST)](./phase-4-dast/README.md)
Runtime vulnerability hunting loop.
- Automated penetration baseline auditing with OWASP ZAP (Zed Attack Proxy)
- Continuous Issue creation on GitHub based on findings
- End-to-End audit trail attached to each CI/CD release.

---
## 🛠 Technology Stack
- **Source Control / CI-CD:** GitHub / GitHub Actions
- **Cloud Provider:** Microsoft Azure
- **Infrastructure as Code:** Terraform
- **Application:** Node.js, Express, Docker
- **Security Scanners:** SonarCloud (SAST), Trivy (SCA), Checkov (IaC), OWASP ZAP (DAST)
