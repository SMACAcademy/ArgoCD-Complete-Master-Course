
# Argo CD and Helm Monitoring and Observability Demonstration

## Overview
This guide demonstrates how to use Argo CD and Helm for monitoring and observability in Kubernetes, focusing on deploying Prometheus and Grafana.

### Step 1: Setting Up Helm Charts
We'll use existing Helm charts for Prometheus and Grafana.

#### Prometheus Helm Chart
- **Repository**: [Prometheus Community](https://github.com/prometheus-community/helm-charts)
- **Chart**: `prometheus-community/prometheus`

#### Grafana Helm Chart
- **Repository**: [Grafana Helm Chart](https://github.com/grafana/helm-charts)
- **Chart**: `grafana/grafana`

### Step 2: Adding Helm Repositories
Add the Helm repositories for Prometheus and Grafana:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

### Step 3: Creating Argo CD Applications
Define Argo CD Applications for both Prometheus and Grafana.

#### Prometheus Argo CD Application (`prometheus-app.yaml`)
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: prometheus
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://prometheus-community.github.io/helm-charts
    targetRevision: HEAD
    chart: prometheus
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

#### Grafana Argo CD Application (`grafana-app.yaml`)
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grafana
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://grafana.github.io/helm-charts
    targetRevision: HEAD
    chart: grafana
  destination:
    server: https://kubernetes.default.svc
    namespace: monitoring
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Step 4: Deploying with Argo CD
Deploy the applications using Argo CD:

```bash
kubectl apply -f prometheus-app.yaml
kubectl apply -f grafana-app.yaml
```

### Step 5: Observing and Configuring
- Access Grafana for visualizing metrics from Prometheus.
- Configure dashboards in Grafana.
- Set up alerts in Prometheus.

### Conclusion
This setup uses Argo CD and Helm to automate the deployment and management of a monitoring and observability solution with Prometheus and Grafana.
