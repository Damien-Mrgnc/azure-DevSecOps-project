# Phase 3: Continuous Deployment (CD) Pipeline

## Objective
Establish a robust continuous deployment pipeline for both Infrastructure as Code (Terraform) and Application (Docker). This phase automates the promotion of validated changes to the Azure production environment, ensuring zero-touch deployments combined with stringent pre-deployment conditions and post-deployment verifications.

## Structural Overview
This phase introduces deployment barriers mapped to git branches and operational health checks.

1. [**Step 1: Automated Terraform Apply**](./01-terraform-apply/README.md) *(Completed)*
2. [**Step 2: App Service Docker Deployment**](./02-app-service-deploy/README.md) *(Completed)*
3. [**Step 3: Post-Deployment Health Check**](./03-health-check/README.md) *(Completed)*
4. [**Step 4: CI/CD Granular Refactoring**](./04-ci-refactoring/README.md) *(Completed)*

---

## Technical Stack
- **GitHub Actions**: Environments and deployment gating.
- **Terraform CLI**: Automated, unattended infrastructure provisioning (`apply -auto-approve`).
- **Azure App Service**: Linux container hosting platform.
- **cURL / Bash**: Dynamic HTTP health probing.
- **Microsoft Entra ID (OIDC)**: Easy Auth interception management validation.
