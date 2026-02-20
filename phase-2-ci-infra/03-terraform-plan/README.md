# Step 3: Terraform Plan Execution

## Description
The ultimate pre-deployment validation step in our Infrastructure pipeline is `terraform plan`. This step executes a dry-run of the infrastructure changes. It reads the current state of resources in Microsoft Azure (authenticating securely via OpenID Connect / OIDC without passwords) and compares it with the local files.

## OIDC Azure Authentication
The pipeline securely connects to Azure using the `azure/login` action with `id-token: write` permission. This grants Terraform the ability to query Azure Resource Manager dynamically and download the existing `.tfstate` from the Azure Storage Account Blob backend without ever storing connection strings.

## Benefits for DevSecOps
- **Predictability**: It explicitly highlights which Azure resources will be created, modified, or destroyed, giving engineers full transparency.
- **Cost Preview**: (If integrated with tools like Infracost) It allows the team to predict how changes to the IaC might impact the monthly cloud bill.
- **Fail-Safe Mechanism**: The `plan` command fails if it encounters dependency loops, conflicting constraints, or if the Azure Identity lacks correct RBAC permissions, preventing the team from pushing a broken configuration to production.
