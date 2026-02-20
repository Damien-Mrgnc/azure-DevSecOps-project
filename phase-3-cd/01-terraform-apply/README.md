# Step 1: Automated Terraform Apply

## Concept
Infrastructure modifications must be planned automatically on every pull request, but only applied automatically upon merging to the protected `main` branch. This is known as "GitOps" or "Shift-Left IaC", ensuring that the tracked branch is always equivalent to the deployed cloud architecture.

## Implementation Details
A new job `terraform-apply` was added to `.github/workflows/infra-ci.yml`.

### Key Directives
1. **Approval Gates**: Contains the conditional check `if: github.ref == 'refs/heads/main' && github.event_name == 'push'` before executing.
2. **Dependent Pipeline**: Configured with `needs: terraform-plan` ensuring that an execution plan is successfully built prior to any actual alteration.
3. **Unattended Execution**: Runs `terraform apply -auto-approve -lock=false` resolving manual prompts typically required locally by an engineer.
4. **Environment Context**: Defined with `environment: production` tying it to GitHub's deployment policies and secrets specific to that sphere.

### Outcome
Any unvetted configuration pushing through unapproved paths gracefully skips applying, guarding the App Service and Data Tiers from unintentional structural outages.
