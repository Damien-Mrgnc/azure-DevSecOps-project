# Step 0: GitFlow Methodology Adoption (Feature Branching)

## Why this change?
During **Phase 1** (Application pipeline construction), we adopted a direct development approach on the main branch (`main`). While effective for quickly bootstrapping the initial project from scratch alone, this method does not represent state-of-the-art collaborative work.

Starting from this **Phase 2 (Infrastructure as Code - Terraform)**, we "shift gears" by adopting strict **DevSecOps** standards and teamwork practices by implementing the **GitFlow** workflow (specifically the Feature Branching Workflow via GitHub).

## The "Feature Branching" Methodology

The golden rule is now as follows: **It is strictly forbidden to push code directly to the `main` branch**. The `main` branch represents Production. If it breaks, the system goes down.

### Lifecycle of a DevSecOps feature:
1. **Creation of a working branch (Feature Branch)**:
   For each new task, a disposable and isolated branch is created from `main`.
   ```bash
   git checkout -b feat/task-name
   ```
2. **Local Development and Securing**:
   The developer (or Cloud Engineer) codes, tests, and deploys locally without impacting the rest of the team.
3. **Push to the remote branch**:
   ```bash
   git push origin feat/task-name
   ```
4. **Opening a Pull Request (PR)**:
   A merge request (Pull Request) is created on GitHub to propose the integration of the new feature into `main`.
5. **Triggering CI Pipelines (The DevSecOps Guard)**:
   This is where automation makes perfect sense. GitHub Actions detects the Pull Request and triggers:
   - Linting (Code formatting).
   - Unit tests.
   - SAST Security Scans (SonarCloud, Checkov for IaC).
   - *If a security error is detected, the Pull Request is automatically blocked.*
6. **Code Review & Merge**:
   If the CI pipeline passes, another engineer performs a code review. Once approved, the Pull Request is merged into `main`.

## Benefits for this DevSecOps Project
- **Security and Quality**: No vulnerable code can reach production without having faced the scanners (Trivy, SonarCloud, Checkov) in an isolated environment (the Pull Request).
- **Traceability**: Every modification to the Cloud infrastructure or the application is documented, justified by a Request, and signed (Cosign).
- **Rollback**: In the event of an incident, it is extremely simple to "Revert" the commit responsible for a failing Pull Request.

*The creation of this document marks the official beginning of this new repository workflow, initialized via the `feat/phase2-infra-ci` branch.*
