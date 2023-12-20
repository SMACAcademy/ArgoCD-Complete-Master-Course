
# Demonstration of Project Finalizers in Argo CD Projects

## Step 1: Create an Argo CD Project with Finalizers
Define an Argo CD `AppProject` with a finalizer in a YAML file:

### 1. Deployment Manifest (`sync-window.yaml`)

This is a simple Kubernetes deployment manifest for an argocd project:

[0-Demo_Files/Project_Intro/project_with_finalizer.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Project_Intro/project_with_finalizer.yaml)



## Step 2: Apply the Project Configuration
Create the project in Argo CD:

```bash
kubectl apply -f 0-Demo_Files/Project_Intro/project_with_finalizer.yaml -n argocd
```

## Step 3: Attempt to Delete the Project
Try deleting the project:

```bash
kubectl delete appprojects.argoproj.io example-project-with-finalizer -n argocd
```

## Step 4: Remove the Finalizer
Manually remove the finalizer to allow deletion:

```bash
kubectl edit appprojects.argoproj.io example-project-with-finalizer -n argocd
```

## Step 5: Confirm Deletion
Confirm that the project is deleted:

```bash
kubectl get appprojects.argoproj.io -n argocd
```

## Use Case
Finalizers in Argo CD projects ensure cleanup actions or checks are performed before full deletion, adding control and safety in resource management.
