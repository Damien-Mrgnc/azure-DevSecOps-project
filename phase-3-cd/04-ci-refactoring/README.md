# Step 4: CI/CD Granular Refactoring

## Concept
As CI/CD functionality scales, managing multi-step monolith jobs degrades observability. Should a monolith pipeline fail, pinpointing whether the disruption originated in Static Code Analysis or Docker Delivery becomes ambiguous without digging through console logs.

## Implementation Details
Both `app-ci.yml` and `infra-ci.yml` were dismantled into granular, discrete, and interdependent jobs.

### Application Pipeline Dissection
Transforming 3 bulk jobs into 7 distinct tasks:
1. `lint`
2. `test` 
3. `sast`
4. `build-and-push` (Only initiated after `[lint, test, sast]`)
5. `container-scan`
6. `container-sign`
7. `deploy`

### Infrastructure Pipeline Dissection
Transforming monolith jobs into pinpoint Terraform tasks:
1. `terraform-fmt`
2. `terraform-validate`
3. `security-scan` (Checkov)
4. `terraform-plan`
5. `terraform-apply`

Each job has independent environments, explicit scopes, `needs` mappings leveraging parallel processing on GitHub Actions Runners, and discrete status indicators for seamless DevSecOps observability.
