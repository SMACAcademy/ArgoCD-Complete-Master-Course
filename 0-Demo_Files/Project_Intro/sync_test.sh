#!/bin/bash

# Assuming ARGOCD_SERVER is set to your Argo CD server's address
ARGOCD_SERVER=localhost:8080

# Syncing an application
curl --request POST --header "Authorization: Bearer $ARGOCD_AUTH_TOKEN" --data '{"name": "myapp", "project": "default", "sync": {"revision": "HEAD"}}' $ARGOCD_SERVER/api/v1/applications/myapp/sync