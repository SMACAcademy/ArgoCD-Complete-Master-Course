
# Dependency Management in Argo CD using Helm

## 1. Prerequisites
- A Kubernetes cluster with Argo CD installed.
- Helm installed locally.

## 2. Demonstration Steps

### Step 1: Create a Main Helm Chart
1. **Initialize Main Helm Chart**:
   ```shell
   helm create main-app
   ```
   Creates the main Helm chart directory structure.

### Step 2: Add Dependencies
1. **Edit `Chart.yaml`**:
   Define dependencies in the main chart's `Chart.yaml`.
   ```yaml
   apiVersion: v2
   name: main-app
   description: A Helm chart for Kubernetes
   version: 0.1.0
   appVersion: "1.0"

   dependencies:
     - name: dependency-app
       version: 0.1.0
       repository: "http://my-chart-repo/"
   ```

2. **Update Dependencies**:
   Run `helm dependency update` to download dependencies.

### Step 3: Customize Values for Dependencies
1. **Edit `values.yaml`**:
   Configure values for dependencies in the main chart's `values.yaml`.
   ```yaml
   replicaCount: 1

   dependency-app:
     someParameter: value
     anotherParameter: value
   ```

### Step 4: Create Argo CD Application Manifest
1. **Argo CD Application Manifest (`argo-app.yaml`)**:
   Define the Argo CD application for the main chart.
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: main-app
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: 'https://your-helm-chart-repo.git'
       path: main-app
       targetRevision: HEAD
     destination:
       server: 'https://kubernetes.default.svc'
       namespace: my-app-namespace
     syncPolicy:
       automated:
         prune: true
         selfHeal: true
   ```

### Step 5: Deploy the Application with Argo CD
1. **Deploy the Main Application**:
   ```shell
   kubectl apply -f argo-app.yaml
   ```

## 3. Managing Dependency Updates
- Update `Chart.yaml` and `values.yaml` for dependency changes.
- Commit and push changes for Argo CD synchronization.

## 4. Monitor Deployment
- Monitor through Argo CD dashboard or `kubectl` commands.

## Conclusion
A comprehensive guide to managing complex applications with dependencies in Kubernetes using Helm and Argo CD.
