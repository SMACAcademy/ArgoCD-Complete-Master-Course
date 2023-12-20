
# Managing Project Quotas and Limits in Argo CD

This guide demonstrates how to set resource quotas and limits within Argo CD projects for efficient resource management.

## 1. Understanding Project Quotas and Limits
- **Resource Quotas** in Kubernetes limit resource consumption in a namespace.
- **Project Limits in Argo CD** define maximum resources for applications within a project.

## 2. Prerequisites
- Kubernetes cluster with Argo CD installed.
- Knowledge of Kubernetes resource management.

## 3. Setting Up a Sample Argo CD Project
Create a new project in Argo CD or use an existing one.

Sample Project Definition (`sample-project.yaml`):
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: sample-project
  namespace: argocd
spec:
  description: "Sample Project with Resource Limits"
  sourceRepos:
    - '*'
  destinations:
    - namespace: 'sample-namespace'
      server: 'https://kubernetes.default.svc'
```

## 4. Applying Resource Quotas in Kubernetes
Define and apply a resource quota in the target namespace.

Resource Quota Definition (`resource-quota.yaml`):
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: sample-quota
  namespace: sample-namespace
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```

Apply the quota:
```bash
kubectl apply -f resource-quota.yaml
```

## 5. Configuring Project Limits in Argo CD
Edit the project to include resource limits.

Updated Project Definition (`project_quota.yaml`):

[0-Demo_Files/Project_Intro/project_quota.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Project_Intro/project_quota.yaml)

Apply the updated configuration:
```bash
kubectl apply -f 0-Demo_Files/Project_Intro/project_quota.yaml
```

Project path
```
0-Demo_Files/Demo_Resource_Limit
```


## 6. Deploying Applications under the Project Quota
Deploy applications within the project to adhere to the set quotas.

## 7. Monitoring and Managing Quotas
- Monitor resource usage in the Argo CD UI.
- Adjust quotas as needed.


