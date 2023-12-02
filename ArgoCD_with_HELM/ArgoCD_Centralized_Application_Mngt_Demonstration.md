
# Argo CD Centralized Application Management Demonstration

## Overview
This guide demonstrates how to use Argo CD for centralized management of multiple applications across different Kubernetes clusters or namespaces.

### Scenario
Manage two applications, `App1` and `App2`, each deployed in separate namespaces or clusters, using Argo CD.

### Prerequisites
- Argo CD installed and accessible.
- Access to Kubernetes clusters or namespaces for deployment.

### Step 1: Application Repositories
Git repositories containing Kubernetes manifests for each application.

#### Example Repository Structure
- **App1 Repository**: `https://github.com/your-org/app1-repo`
  - Contains Kubernetes manifests for `App1`.
- **App2 Repository**: `https://github.com/your-org/app2-repo`
  - Contains Kubernetes manifests for `App2`.

### Step 2: Creating Argo CD Applications
Define an Argo CD Application for each application.

#### App1 Argo CD Application (`app1-argo-app.yaml`)
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app1
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/app1-repo
    targetRevision: HEAD
    path: path-to-app1-manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: app1-namespace
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

#### App2 Argo CD Application (`app2-argo-app.yaml`)
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app2
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/app2-repo
    targetRevision: HEAD
    path: path-to-app2-manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: app2-namespace
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Step 3: Deploying with Argo CD
Deploy the applications using Argo CD:

```bash
kubectl apply -f app1-argo-app.yaml
kubectl apply -f app2-argo-app.yaml
```

### Step 4: Centralized Management
Manage both applications from the Argo CD dashboard, including status viewing, syncing, and applying updates.

### Conclusion
Argo CD is used to centrally manage multiple applications, providing a cohesive view and control over diverse application deployments.
