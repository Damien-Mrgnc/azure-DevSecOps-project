# Step 3: Azure App Service OIDC Deployment

## Description
This step secures automated deployment of the analyzed Docker architecture onto an Azure App Service container resource relying explicitly on the OIDC identity management rather than stored platform credentials.

## Implemented Components
1. **OIDC Integration Sequence**: Configured GitHub Actions permissions (`id-token: write, contents: read`) to compute trusted JWT handshakes with Microsoft Entra ID context dynamically.
2. **Secure Registry Telemetry**: Acquired the precise immutable Docker identifier (`${{ github.sha }}`) from the Azure Container Registry avoiding ambiguous "latest" configurations mapping and ensuring persistent drift control.
3. **Web App Deployment Action**: Managed the automated trigger directly reaching the `azure/webapps-deploy@v2` Azure API to deploy the resulting verified container image.

## Deliverables
*   `.github/workflows/app-ci.yml`: Pipeline configured specifically targeting Azure deployments mapping OIDC to structural actions.
*   `terraform/`: Baseline infrastructural definition supporting App Service Plan and Web App targets, defined previously.
