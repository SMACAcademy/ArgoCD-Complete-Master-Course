
# Custom Resource Definitions (CRDs) Handling in Argo CD using Helm

## 1. Prerequisites
- A Kubernetes cluster with Argo CD installed.
- Helm installed locally.

## 2. Demonstration Steps

### Step 1: Create a Helm Chart with CRDs
1. **Initialize Helm Chart**:
   ```shell
   helm create crd-app
   ```
   Creates a basic Helm chart structure.

### Step 2: Add CRDs to the Chart
1. **Create CRD Files** in `crds/` directory:
   ```yaml
   apiVersion: apiextensions.k8s.io/v1
   kind: CustomResourceDefinition
   metadata:
     name: myresources.mydomain.com
   spec:
     group: mydomain.com
     versions:
       - name: v1
         served: true
         storage: true
     scope: Namespaced
     names:
       plural: myresources
       singular: myresource
       kind: MyResource
   ```

### Step 3: Reference CRDs in Templates
1. **Use CRDs in Helm Templates** in `templates/my-resource.yaml`.
   ```yaml
   apiVersion: mydomain.com/v1
   kind: MyResource
   metadata:
     name: example
   spec:
     ...
   ```

### Step 4: Create Argo CD Application Manifest
1. **Argo CD Application Manifest (`argo-app.yaml`)**:
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: crd-app
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: 'https://your-helm-chart-repo.git'
       path: crd-app
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
1. **Deploy the Application**:
   ```shell
   kubectl apply -f argo-app.yaml
   ```

## 3. Best Practices for CRDs Management
- Keep CRDs under version control.
- Ensure CRDs application is idempotent.
- Monitor CRD instances within the cluster.

## 4. Monitor Deployment
- Monitor through Argo CD dashboard or `kubectl` commands.

## Conclusion
A guide on managing Custom Resource Definitions in Kubernetes using Helm and Argo CD.
