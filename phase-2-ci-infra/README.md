# Phase 2: Infrastructure as Code (IaC) Continuous Integration (CI) Pipeline

## Objective
Establish a robust continuous integration pipeline specifically for the Terraform IaC. This pipeline validates the Azure infrastructure definitions for syntactical correctness, deploys execution plans, and strictly enforces security baselines using advanced static analysis tools to prevent misconfigurations (e.g., exposed databases, unencrypted Key Vaults) from reaching staging or production environments.

## Structural Overview
This phase introduces strict GitFlow branching mechanics and integrates specialized IaC security scanners.

0. [**Step 0: GitFlow Methodology Adoption**](./00-gitflow-methodology/README.md) *(Completed)*
1. [**Step 1: Terraform Linting and Formatting**](./01-lint-format/README.md) *(Pending)*
2. [**Step 2: IaC Security Scanning with Checkov/Terrascan**](./02-security-scan/README.md) *(Pending)*
3. [**Step 3: Terraform Plan Execution**](./03-terraform-plan/README.md) *(Pending)*

---

## Technical Stack
- **GitHub Actions**: Infrastructure CI pipeline orchestration (YAML).
- **Terraform CLI**: Native formatting (`fmt`) and syntactical validation (`validate`).
- **Checkov**: Advanced Static Application Security Testing (SAST) specialized for infrastructure configurations.
- **Azure CLI / OIDC**: Secure, secret-less authentication backbone required for plan generation against Azure state.
