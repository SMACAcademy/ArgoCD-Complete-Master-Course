
# Synchronizing Projects with Repositories in Argo CD

This guide demonstrates how Argo CD synchronizes projects with Git repositories, ensuring that Kubernetes deployments match the desired state.

## 1. Understanding Synchronization in Argo CD
- **Synchronization**: Argo CD ensures the cluster state matches the configuration in Git repositories.
- **Automatic vs Manual Sync**: Sync can be configured as automatic or manual.

## 2. Prerequisites
- Operational Argo CD instance.
- Git repository with Kubernetes manifests.

## 3. Setting Up a Sample Project in Argo CD
Create or use an existing project in Argo CD.

Sample Project Definition (`sample-project.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: sample-project
  namespace: argocd
spec:
  description: "Sample Project"
  sourceRepos:
    - "https://github.com/yourusername/your-repo.git"
  destinations:
    - namespace: 'default'
      server: 'https://kubernetes.default.svc'
```

Apply the project:
```bash
kubectl apply -f sample-project.yaml
```

## 4. Creating an Application in the Project
Define an application in the project.

Application Definition (`app.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp
  namespace: argocd
spec:
  project: sample-project
  source:
    repoURL: 'https://github.com/yourusername/your-repo.git'
    path: path/to/app
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Apply the application:
```bash
kubectl apply -f app.yaml
```

## 5. Synchronizing the Application
- **Automatic Sync**: Automatically synchronizes changes from the repository.
- **Manual Sync**: Manually trigger sync in Argo CD UI or CLI.

## 6. Verifying Synchronization
Check the sync status in the Argo CD dashboard.

## 7. Best Practices
- Use automatic sync for continuous delivery environments.
- Prefer manual sync for production for better control.
- Test changes in separate environments before production.

## 8. Conclusion
Synchronization in Argo CD is key to GitOps, ensuring deployments match the repository's desired state.

For detailed instructions, refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/).
