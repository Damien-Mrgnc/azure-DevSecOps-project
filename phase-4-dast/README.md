# Phase 4: Dynamic Application Security Testing (DAST)

## Objective
Implement dynamic security testing (DAST) on the running application using OWASP ZAP (Zed Attack Proxy). This phase verifies the application's external security posture after it has been deployed to the target environment (Azure App Service).

## Structural Overview
This phase introduces continuous dynamic testing integrated into the deployment pipeline.

1. [**Step 1: OWASP ZAP Baseline Scan**](./01-owasp-zap/README.md) *(Completed)*

---

## Technical Stack
- **GitHub Actions**: Automated vulnerability scanning workflows.
- **OWASP ZAP (Zed Attack Proxy)**: Dynamic web application security scanner.
- **Docker**: Containerized execution of the ZAP toolkit and reporting.
- **GitHub Issues Integration**: Automatic issue generation for detected vulnerabilities.
