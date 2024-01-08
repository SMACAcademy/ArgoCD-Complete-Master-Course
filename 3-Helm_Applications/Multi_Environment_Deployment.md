
# Multi-Environment Deployment with Argo CD and Helm

## 1. Prerequisites
- A Kubernetes cluster.
- Argo CD installed in your cluster.
- Helm installed locally.

## 2. Step-by-Step Guide


### ArgoCD with Helm and Multiple Values Files

This guide demonstrates how to use ArgoCD with a Helm chart and multiple values files for different environments like staging and production.

### Step 1: Helm Chart Structure

Your Helm chart should have the following structure:

```
my-helm-chart/
│
├── Chart.yaml
├── values.yaml
├── values-staging.yaml
├── values-production.yaml
│
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    └── ...
```

### Step 2: Example Values Files

- `values.yaml`: Default values.
- `values-staging.yaml`: Overrides for the staging environment.
- `values-production.yaml`: Overrides for the production environment.

### Step 3: ArgoCD Application Manifests

Create two application manifests for ArgoCD, one for each environment.

### Staging Application (`staging-application.yaml`)

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app-staging
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://your-git-repository-url.git'
    path: my-helm-chart
    targetRevision: HEAD
    helm:
      valueFiles:
        - values-staging.yaml
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: staging
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Production Application (`production-application.yaml`)

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app-production
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://your-git-repository-url.git'
    path: my-helm-chart
    targetRevision: HEAD
    helm:
      valueFiles:
        - values-production.yaml
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Step 4: Deploy Applications using ArgoCD CLI

Deploy the applications using the ArgoCD CLI:

1. Log in to your ArgoCD server:

   ```bash
   argocd login <ARGOCD_SERVER>
   ```

2. Apply the application manifests:

   ```bash
   argocd app create -f staging-application.yaml
   argocd app create -f production-application.yaml
   ```

Replace placeholders like the Git repository URL and Kubernetes server with your actual information.


### 3. Verify Deployment
- Check the Argo CD UI or use `kubectl` to verify that the applications are deployed correctly in each environment.

### 4. Update and Sync
- To update an environment, modify the respective values file and sync the application in Argo CD.
