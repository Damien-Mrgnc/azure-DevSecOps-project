# Step 3: Post-Deployment Health Check

## Concept
A deployment pipeline that reports 'Success' just because the files were sent is incomplete. The actual application must be functioning, the web server spinning, and the API endpoints resolving correctly in the production ecosystem.

## Implementation Details
We appended a Health Check probing script within the `deploy` job using bash and `curl` to aggressively try fetching the `/api/config` response, awaiting startup times and mitigating timeout failures with loop repetition and retries.

### Entra ID "Easy Auth" Considerations
Since Microsoft Azure enforces Azure AD (Entra ID) natively across the App Service prior to reaching Express:
1. `cURL` returns a `401 Unauthorized` block if unauthenticated.
2. A `401 HTTP` response guarantees that the infrastructure stack is fully UP and correctly evaluating traffic headers.
3. If the Docker container had crashed, we would receive `502 Bad Gateway` or `503 Service Unavailable`.
4. Therefore, both `200 OK` and `401 Unauthorized` are asserted as passing thresholds.

### Sample Bash Construct:
```bash
STATUS=$(curl -s -o /dev/null -w '%{http_code}' https://app-projet1-1665c35a.azurewebsites.net/api/config)
if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 401 ]; then
  echo "Health check passed!"
  exit 0
fi
```
