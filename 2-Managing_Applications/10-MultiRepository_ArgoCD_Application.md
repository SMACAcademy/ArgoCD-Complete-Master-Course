
# Argo CD Multi-Repository Application Example

## Overview
This guide provides an example of setting up an Argo CD application using multiple source repositories.

### Scenario
- **Primary Repository**: Contains main Kubernetes manifests.
  - URL: `https://github.com/example-org/k8s-main-config`
  - Path: `deploy/production`
- **Secondary Repository**: Holds additional configuration (ConfigMaps, Secrets).
  - URL: `https://github.com/example-org/k8s-additional-config`
  - Path: `config`

### Argo CD Application Manifest

#### `multi-source-app.yaml`
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: multi-source-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/SMACAcademy/k8s-main-config.git
    targetRevision: main
    path: deploy/production
    sources:
      - repoURL: https://github.com/SMACAcademy/k8s-additional-config.git
        targetRevision: main
        path: config
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Deploying the Application

1. **Add Repositories to Argo CD**:
   ```bash
   argocd repo add https://github.com/example-org/k8s-main-config --name main-config
   argocd repo add https://github.com/example-org/k8s-additional-config --name additional-config
   ```

2. **Deploy the Application**:
   ```bash
   kubectl apply -f multi-source-app.yaml
   ```

3. **Sync the Application in Argo CD**:
   ```bash
   argocd app sync multi-source-application
   ```

### Repository Contents
The zip file includes two repositories with example Kubernetes configurations:
- `k8s-main-config`: Contains deployment manifests.
- `k8s-additional-config`: Contains a ConfigMap configuration.


### Notes
- Ensure Argo CD can access these GitHub repositories.
- Validate your YAML files and paths.
- Adjust configurations according to your setup.
