
# Argo CD and Helm Compliance and Policy Enforcement Demonstration

## Overview
This guide demonstrates how to use Argo CD and Helm for compliance and policy enforcement in Kubernetes deployments.

### Scenario
Enforcing specific compliance rules for Kubernetes deployments using Helm templates and Argo CD for deployment management.

### Step 1: Creating a Helm Chart
A Helm chart is created to include deployment templates with required compliance policies.

#### Directory Structure
```
my-helm-chart/
│
├── Chart.yaml
└── templates/
    └── deployment.yaml
```

#### `Chart.yaml`
```yaml
apiVersion: v2
name: my-helm-chart
description: A Helm chart for Kubernetes
version: 0.1.0
```

#### `deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-application
  labels:
    app: my-application
    compliance: enforced
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-application
  template:
    metadata:
      labels:
        app: my-application
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        resources:
          limits:
            cpu: "500m"
            memory: "128Mi"
          requests:
            cpu: "250m"
            memory: "64Mi"
```

### Step 2: Setting Up Argo CD
Setting up Argo CD to manage deployments from the Helm chart.

#### `argo-app.yaml`
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-helm-chart-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/your-org/my-helm-chart-repo.git
    targetRevision: HEAD
    path: my-helm-chart
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Step 3: Deploying with Argo CD
Deploy the application using the following command:
```bash
kubectl apply -f argo-app.yaml
```

### Step 4: Observing Enforcement
Verify the deployment adheres to the compliance policy using Kubernetes commands.

### Conclusion
This setup uses Helm for defining Kubernetes resources with compliance policies and Argo CD for managing and enforcing these policies in deployments.
