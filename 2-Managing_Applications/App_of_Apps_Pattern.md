
# App of Apps Pattern in Argo CD Guide

## Step-by-Step Demonstration of the App of Apps Pattern

This guide demonstrates how to use the App of Apps pattern in Argo CD, assuming Argo CD is already installed in your Kubernetes cluster.

### Step 1: Overview of App of Apps Pattern

The App of Apps pattern involves a hierarchical structure where a 'root' Argo CD application manages the deployment of other Argo CD applications, which in turn deploy actual workloads.

### Step 2: Create the Root Application Manifest

First, create a manifest for the root application. This application will deploy other applications.

**root-application.yaml**:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: root-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://your-git-repo-url.git'
    path: apps
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

The `source.path` should point to a directory in your Git repository containing the child applications' manifests.

### Step 3: Create Child Application Manifests

In the `apps` directory of your Git repository, place manifests for each child application. For example:

**guestbook-application.yaml**:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/argoproj/argocd-example-apps.git'
    path: guestbook
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: guestbook
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Step 4: Deploy the Root Application

Deploy the root application using `kubectl`:

```sh
kubectl apply -f root-application.yaml
```

### Step 5: Verify the Applications

After deploying the root application, check the Argo CD UI or use the CLI to verify the status of the applications.

### Step 6: Update and Manage Applications

Modify the `apps` directory in your Git repository to manage the child applications. The root application will sync these changes.

## Additional Considerations

- **Repository Structure:** Organize your repository for clarity.
- **Security:** Set up proper RBAC and permissions.
- **Sync Policy:** Adjust according to your deployment strategy.

This pattern allows effective management and scalability of complex deployments in Argo CD.
