# Infrastructure as Code (Terraform)

## Description
This folder contains all Terraform manifests required for deploying the infrastructure on Microsoft Azure. The architecture is modular and follows security and maintainability best practices.

**Note on Security & Costs (Lab Mode):**
Some enterprise-grade security features (Private Endpoints, ACR Premium, SQL Zone Redundancy, Vulnerability Assessment) are intentionally disabled in LAB mode to keep Azure costs minimal.

## File Structure
The infrastructure is logically split:

*   `main.tf`: Main configuration, Azure Provider definition.
*   `compute.tf`: App Service Plan and Azure App Service (Linux) definition.
*   `database.tf`: Azure SQL server and database configuration.
*   `network.tf`: Virtual Network (VNet), subnets (Public/Private), and Network Security Groups (NSG) creation.
*   `security.tf`: Azure Key Vault configuration and Access Policies.
*   `monitoring.tf`: Observability infrastructure (Log Analytics Workspace, Application Insights).
*   `alerts.tf`: Action Groups and Alert Rules definition (CPU, Availability).
*   `registry.tf`: Azure Container Registry (ACR) configuration.
*   `variables.tf`: Input variable declarations.
*   `outputs.tf`: Output value definitions (URLs, IDs).

## Usage
To deploy the infrastructure:

1.  Initialize Terraform:
    ```bash
    terraform init
    ```

2.  View the execution plan:
    ```bash
    terraform plan
    ```

3.  Apply changes:
    ```bash
    terraform apply
    ```
