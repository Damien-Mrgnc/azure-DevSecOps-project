# Step 2: IaC Security Scanning with Checkov

## Description
Securing Infrastructure as Code (IaC) means scanning the configuration files *before* they are deployed. In this step, we integrated **Checkov** into our GitHub Actions pipeline (`infra-ci.yml`) to perform Static Application Security Testing (SAST) specifically designed for Terraform.

Checkov analyzes `terraform/` configurations against hundreds of cloud security best practices and compliance standards (like CIS, HIPAA, PCI-DSS).

## What we fixed
By running Checkov, we identified and resolved several security gaps in the initial architecture without incurring additional Azure costs:
- **Networking**: Replaced permissive `0.0.0.0/0` rules on SSH/HTTP with strict `Internet` or HTTPS-only rules.
- **App Service**: Enforced HTTPS, TLS 1.2 minimum, HTTP/2, FTP disablement, and enabled diagnostic logging.
- **SQL Server**: Enforced TLS 1.2 minimum, integrated Azure AD (Entra ID) administrator login, and removed overly permissive firewall rules.
- **Key Vault**: Enabled Purge Protection to prevent accidental/malicious deletion of secrets, and enforced expiration dates on stored passwords.

## Handling Lab Constraints (`checkov:skip`)
Some security best practices recommend enabling enterprise-grade features (e.g., Private Endpoints, Geo-Redundancy, Premium SKUs). Since this project is a **Lab Environment**, we cannot enable these features as they incur significant Azure costs.

Instead of turning off the scanner entirely, we used inline `checkov:skip` comments. This is a DevSecOps best practice: **Risk Acceptance**. We explicitly acknowledge a security rule and state exactly *why* we are skipping it (e.g., `# checkov:skip=CKV_AZURE_222: "Private Endpoints are too expensive for this lab"`). This ensures the scanner remains active for all other rules and the accepted risks are documented in the code itself.
