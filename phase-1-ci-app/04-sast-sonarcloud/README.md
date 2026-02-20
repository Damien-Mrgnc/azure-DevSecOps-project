# Step 4: Static Application Security Testing (SAST) with SonarCloud

## Description
This step implements static application security testing (SAST) utilizing SonarCloud to analyze the application source material. This procedure acts as a rigid Quality Gate, flagging vulnerabilities such as hardcoded tokens, structural logic errors, or lacking unit test coverage prior to execution.

## Implemented Components
1. **SonarCloud Instance Configuration**: Connected the GitHub repository to the SonarCloud inspection workspace globally handling `SONAR_TOKEN` pipeline secrets via secure encapsulation.
2. **Scanner Architecture and Targeting**: Defined the specific directories and files (`app/src`) mapped for inspection exclusively ignoring internal configuration tools. Activated Jest coverage report extraction via the `--coverage` marker.
3. **Workflow Native Action Implementation**: Processed the `sonarsource/sonarcloud-github-action@master` utility enforcing the Quality Gate. SonarCloud is provisioned to automatically halt standard CI/CD completion if conditions exceed established critical levels.

## Deliverables
*   `sonar-project.properties`: Specification file mapping organizational indices (`damien-mrgnc`), exclusions, and lcov output target directories.
*   `.github/workflows/app-ci.yml`: Modified logic enforcing SAST analysis directly trailing local execution processes.
*   `app/package.json`: Updated `jest` scripts to automatically render code coverage metrics.
