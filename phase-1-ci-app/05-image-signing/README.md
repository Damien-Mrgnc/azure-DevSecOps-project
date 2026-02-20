# Step 5: Cryptographic Image Signing with Cosign

## Description
This step introduces cryptographic verification into the supply chain. By digitally signing the Docker container before deployment, we guarantee that the artifact deployed to Azure Web App is the exact, un-tampered image synthesized and analyzed within this pipeline. Relying on Keyless Signing (Sigstore OIDC integration), this system prevents secret lifecycle mismanagement.

## Implemented Components
1. **GitHub Runner Permissions**: Granted the `packages: write` capability to the runner profile allowing interaction with container registries' metadata components.
2. **Cosign Automation**: Provisioned `sigstore/cosign-installer` seamlessly within the runtime to handle signing executions automatically based on transient GitHub Identity.
3. **Immutable Tag Target**: Configured the signing execution `cosign sign --yes <IMAGE_TAG>` exclusively against the dynamic commit hash (`${{ github.sha }}`). This provides an auditable link between a signed image block and the precise source configuration responsible for producing it.

## Deliverables
*   `.github/workflows/app-ci.yml`: Pipeline configured with Cosign framework installation and execution stages immediately preceding deployment triggers.
