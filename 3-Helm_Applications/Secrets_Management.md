
# Secrets Management in Argo CD using Helm

## 1. Prerequisites
- A Kubernetes cluster with Argo CD installed.
- Helm installed locally.
- Access to a secrets management solution (e.g., HashiCorp Vault, AWS Secrets Manager).

## 2. Demonstration Steps

### Step 1: Create a Helm Chart
1. **Initialize Helm Chart**:
   ```shell
   helm create secret-app
   ```
   Creates a basic Helm chart structure.

### Step 2: Define Secrets in Helm Chart
1. **Create Secrets Template** in `templates/secret.yaml`:
   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-secret
   type: Opaque
   data:
     password: {{ .Values.secret.password | b64enc | quote }}
   ```

2. **Configure Secret Values** in `values.yaml`:
   ```yaml
   secret:
     password: "default-password"
   ```

### Step 3: Secure Secret Values
- Use external secrets managers or replace placeholder values securely.

### Step 4: Create Argo CD Application Manifest
1. **Argo CD Application Manifest (`argo-app.yaml`)**:
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: secret-app
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: 'https://your-helm-chart-repo.git'
       path: secret-app
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

## 3. Best Practices for Secret Management
- Avoid storing plain-text secrets in version control.
- Use external secrets management systems.
- Regularly rotate secrets.

## 4. Monitor Deployment
- Monitor through Argo CD dashboard or `kubectl` commands.

## Conclusion
A guide on managing secrets in Kubernetes using Helm and Argo CD, with an emphasis on security.
