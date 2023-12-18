
# Using Argo CD Project Role Token in CI/CD Pipelines

## Environment Setup
In your CI/CD pipeline configuration, set the Argo CD token as an environment variable. This is typically done in the settings of your CI/CD platform.

```yaml
environment:
  ARGOCD_AUTH_TOKEN: <your-token>
```

## Using the Token in CI/CD Scripts
In the pipeline script, use the token to interact with Argo CD. For example, to sync an application named `myapp` in `myproject`, your script might look like this:

```bash
#!/bin/bash

# Assuming ARGOCD_SERVER is set to your Argo CD server's address
ARGOCD_SERVER=<your-argocd-server>

# Syncing an application
curl --request POST      --header "Authorization: Bearer $ARGOCD_AUTH_TOKEN"      --data '{"name": "myapp", "project": "myproject", "sync": {"revision": "HEAD"}}'      $ARGOCD_SERVER/api/v1/applications/myapp/sync
```

This example demonstrates how the token can be used in automated scripts within CI/CD pipelines to perform operations in Argo CD, like syncing applications, in a secure and authenticated manner.
