# Step 2: Image Compilation, Security Scanning, and Registry Push

## Description
This step packages the Node.js application into an immutable container artifact and inspects it comprehensively for systemic and application-level vulnerabilities prior to deployment, enforcing a strict "Shift Left" DevSecOps philosophy.

## Implemented Components
1. **Multi-Architecture Docker Build (Buildx)**: Compiled the image using immutable tagging tied to the Git commit hash (`${{ github.sha }}`) alongside a floating `latest` tag.
2. **Container Security Enforcement (Trivy)**: Configured Aqua Security's vulnerability scanner to aggressively inspect both the base OS layer and associated code libraries. Any alert flagged as `CRITICAL` or `HIGH` with an available fix triggers a hard pipeline failure (`exit-code: 1`).
3. **Azure Container Registry (ACR) Transmission**: Conditionally orchestrated the network transfer of the synthesized container only if the prior scanning step reported zero blockable flaws.

## Deliverables
*   `app/Dockerfile`: Container image build instructions.
*   `.github/workflows/app-ci.yml`: Pipeline steps configured for Buildx, Trivy scanning, and Docker transmission.
*   `proofs/trivy_sample_output.txt`: Expected visualization format of a Trivy inspection demonstrating blocked vulnerabilities.
