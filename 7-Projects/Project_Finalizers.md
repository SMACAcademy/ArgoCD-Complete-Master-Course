
# Demonstration of Project Finalizers in Argo CD Projects

## Step 1: Create an Argo CD Project with Finalizers
Define an Argo CD `AppProject` with a finalizer in a YAML file:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: example-project-with-finalizer
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  description: "Example project with finalizers"
  sourceRepos:
    - '*'
  destinations:
    - namespace: 'default'
      server: 'https://kubernetes.default.svc'
```

## Step 2: Apply the Project Configuration
Create the project in Argo CD:

```bash
kubectl apply -f project_with_finalizer.yaml
```

## Step 3: Attempt to Delete the Project
Try deleting the project:

```bash
kubectl delete appprojects.argoproj.io example-project-with-finalizer
```

## Step 4: Remove the Finalizer
Manually remove the finalizer to allow deletion:

```bash
kubectl edit appprojects.argoproj.io example-project-with-finalizer
```

## Step 5: Confirm Deletion
Confirm that the project is deleted:

```bash
kubectl get appprojects.argoproj.io
```

## Use Case
Finalizers in Argo CD projects ensure cleanup actions or checks are performed before full deletion, adding control and safety in resource management.
