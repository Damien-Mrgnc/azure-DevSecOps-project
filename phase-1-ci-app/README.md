# Phase 1: Application Continuous Integration (CI) Pipeline

## Objective
Establish a robust continuous integration pipeline designed to rigorously validate, compile, secure, and stage the Node.js application codebase prior to staging or production deployment.

## Structural Overview

This phase is architected into distinct sub-modules to enforce DevSecOps best practices throughout the build lifecycle:

1. [**Step 1: Workflow Foundation, Linting, and Testing**](./01-base-workflow-lint-test/README.md) *(Completed)*
2. [**Step 2: Container Build, Vulnerability Scanning (Trivy), and Delivery**](./02-build-scan-push-docker/README.md) *(Completed)*
3. [**Step 3: Azure App Service Deployment via OIDC**](./03-deploiement-appservice/README.md) *(Completed)*
4. [**Step 4: Static Application Security Testing (SAST) with SonarCloud**](./04-sast-sonarcloud/README.md) *(Completed)*
5. [**Step 5: Cryptographic Image Signing (Cosign Sigstore)**](./05-image-signing/README.md) *(Optional/Pending)*

---

## Technical Stack
- **GitHub Actions**: Infrastructure and CI/CD pipelines as code (YAML).
- **Jest & ESLint**: Frameworks for unit testing verification and code quality standard enforcement.
- **Docker Buildx**: Multi-architecture container build engine.
- **Trivy (Aqua Security)**: Comprehensive container vulnerability scanner.
- **Azure Container Registry (ACR)**: Secure hosting architecture for enterprise containers.
- **SonarCloud**: Advanced static code analyzer and continuous inspection engine.
- **Cosign (Sigstore)**: Cryptographic signature framework guaranteeing container integrity (Keyless mode).
