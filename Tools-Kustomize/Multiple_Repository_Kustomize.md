
# Argo CD Multi-Repository Application Setup Guide

## Overview
This guide explains how to set up an Argo CD application that retrieves sources from multiple repositories.

### 1. Primary Application Repository
The primary application repository contains the main configuration and references to other repositories.

### 2. Secondary Repositories
These are repositories containing different parts of your application configuration, such as database and frontend services.

### 3. Using Kustomize
Kustomize is used to reference resources from other repositories.

#### `kustomization.yaml` Example
```yaml
resources:
  - github.com/your-organization/frontend-config//path-to-manifests?ref=main
  - github.com/your-organization/backend-config//path-to-manifests?ref=main
```

### 4. Argo CD Application Manifest
Create an Argo CD application manifest in your primary repository.

#### `app.yaml` Example
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: multi-repo-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-organization/primary-repo.git
    targetRevision: HEAD
    path: path-to-kustomization
  destination:
    server: https://kubernetes.default.svc
    namespace: your-namespace
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### 5. Deploying Application in Argo CD

#### Adding Repositories
Add your repositories to Argo CD:
```bash
argocd repo add https://github.com/your-organization/primary-repo.git --name primary-repo
argocd repo add https://github.com/your-organization/frontend-config.git --name frontend-config
argocd repo add https://github.com/your-organization/backend-config.git --name backend-config
```

#### Deploying the Application
Apply the `app.yaml`:
```bash
kubectl apply -f app.yaml
```

### 6. Syncing Application
Sync the application in Argo CD:
```bash
argocd app sync multi-repo-app
```

### Notes
- Ensure Argo CD has the necessary permissions to access all repositories.
- Validate YAML files for correctness.
- Configure Argo CD properly to handle multiple repositories.
- Adjust configurations according to your setup.
