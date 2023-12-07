
# Namespaces and Project Isolation in Argo CD

This guide provides a demonstration of using namespaces and project isolation in Argo CD, including sample files, commands, and explanations.

## 1. Understanding Namespaces and Project Isolation
- **Namespaces in Kubernetes**: Used to partition a cluster into virtual clusters.
- **Project Isolation in Argo CD**: Groups applications and provides deployment boundaries.

## 2. Prerequisites
- Kubernetes cluster with Argo CD installed.
- Understanding of Kubernetes namespaces and Argo CD.

## 3. Setting Up Kubernetes Namespaces
Create namespaces for development and production environments.

```bash
kubectl create namespace development
kubectl create namespace production
```

## 4. Creating Argo CD Projects for Each Namespace
Define Argo CD projects targeting specific namespaces.

### Development Project (`development-project.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: development-project
  namespace: argocd
spec:
  description: "Development Environment"
  sourceRepos:
    - '*'
  destinations:
    - namespace: development
      server: 'https://kubernetes.default.svc'
```

### Production Project (`production-project.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: production-project
  namespace: argocd
spec:
  description: "Production Environment"
  sourceRepos:
    - '*'
  destinations:
    - namespace: production
      server: 'https://kubernetes.default.svc'
```

## 5. Applying the Project Configurations
Apply the project configurations to Argo CD.

```bash
kubectl apply -f development-project.yaml
kubectl apply -f production-project.yaml
```

## 6. Deploying Applications to Specific Namespaces
Specify the project when deploying applications to ensure correct namespace deployment.

### Example Application Deployment (`app-dev-deployment.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp-development
  namespace: argocd
spec:
  project: development-project
  source:
    repoURL: 'https://github.com/my/repo.git'
    path: path/to/app
    targetRevision: HEAD
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: development
```

## 7. Benefits of Using Namespaces with Argo CD Projects
- Isolation between different environments or teams.
- Enhanced security and scope limitation.
- Effective resource management.

## 8. Best Practices
- Implement RBAC for access control.
- Define clear naming conventions.
- Regularly update access policies and project configurations.

## Conclusion
Using namespaces with Argo CD projects creates isolated and manageable environments for application development and deployment.

For more information, refer to the [official Kubernetes documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) and [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/).
