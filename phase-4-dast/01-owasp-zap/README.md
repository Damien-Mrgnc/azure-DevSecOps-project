# Step 1: OWASP ZAP Baseline Scan

## Goal
To introduce continuous dynamic application security testing (DAST) right after the deployment phase using the OWASP ZAP Baseline action (`action-baseline@v0.14.0`). It ensures that running services maintain secure HTTP headers, cookie configurations, and prevent classic web vulnerabilities.

## How it works
1. **Pipeline Execution**: Following the deployment and the Health Check on Azure, the `dast` job triggers.
2. **Docker Isolation**: A ZAP stable container pulls in and runs a 1-minute spider baseline over the `*.azurewebsites.net` application URL.
3. **Workspace Permissions Fix**: Handled Linux/Runner permission bridging to allow Docker containers to inject `zap.yaml` and Zip archives inside the Github Runner working directory.
4. **Action Outcome**: 
    - The `fail_action: false` argument avoids breaking the deployment while surfacing security alerts.
    - ZAP calls the GitHub API (`issues: write` action permissions) to automatically spawn an Issue describing the warnings.
    - Test artifacts (HTML/JSON/MD Zip) are uploaded and attached to the run summary for Developer review.

## Results
- The application exposes a solid posture for a production-grade WebApp (No Critical/Fail entries).
- Identifies modern hardening requirements (CSP, SameSite cookies, HSTS flags) to iterate on the developer backlog.
