
# Multi-Environment Deployment with Argo CD and Helm

## 1. Prerequisites
- A Kubernetes cluster.
- Argo CD installed in your cluster.
- Helm installed locally.

## 2. Step-by-Step Guide

### Step 1: Create a Helm Chart
1. **Initialize a Helm Chart**: Create a new Helm chart.
   ```shell
   helm create my-app
   ```
2. **Structure the Chart**: The basic structure will look like this:
   ```
   my-app/
   ├── Chart.yaml
   ├── values.yaml
   ├── charts/
   ├── templates/
   ```

### Step 2: Create Values Files for Environments
1. **Default Values**: `values.yaml` will have default values.
2. **Environment-Specific Values**: Create separate values files for each environment.
   - `values-staging.yaml` for the staging environment.
   - `values-prod.yaml` for the production environment.

### Step 3: Customize Templates
1. Customize the templates in the `templates/` directory of your Helm chart to use values from the values files.

### Step 4: Create Argo CD Applications
1. **Create Application Manifests**: For each environment, create an Argo CD Application manifest.
   - `app-staging.yaml`
   - `app-prod.yaml`
   
2. **Example Application Manifest** (`app-staging.yaml`):
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: my-app-staging
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: 'https://your-repo-url.git'
       path: helm/my-app
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
   Repeat for the production environment with `values-prod.yaml`.

### Step 5: Deploy Argo CD Applications
1. Apply the application manifests to your Kubernetes cluster.
   ```shell
   kubectl apply -f app-staging.yaml
   kubectl apply -f app-prod.yaml
   ```

2. Argo CD will pick up these applications and deploy them to the respective environments using the specified values files.

## 3. Verify Deployment
- Check the Argo CD UI or use `kubectl` to verify that the applications are deployed correctly in each environment.

## 4. Update and Sync
- To update an environment, modify the respective values file and sync the application in Argo CD.
