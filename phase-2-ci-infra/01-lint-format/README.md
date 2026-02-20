# Step 1: Terraform Linting and Formatting

## Description
Establishing a common coding standard is the first step of Infrastructure as Code reliability.
By enforcing `terraform fmt -check -recursive` into the CI/CD pipeline, we mathematically guarantee that all submitted code conforms to the universal HashiCorp formatting guidelines.

Additionally, `terraform validate` runs on every commit. It verifies the syntax, block structure, and dependencies without calling out to remote cloud APIs or querying state data. This acts as our safety net to catch basic typos or missing parameters before advanced scanners take over.

## Implementation details
- **Commands used**: `terraform fmt`, `terraform init -backend=false`, and `terraform validate`.
- **Pipeline Position**: `infra-ci.yml` (Runs first, before security scans).
- **Enforcement rule**: The pipeline stops immediately if validation or formatting fails, ensuring no malformed HCL reaches the main branch.
