
# Demonstrating Application Refresh and Hard Refresh in Argo CD

This guide provides sample files and commands to demonstrate the `refresh` and `hard refresh` options in Argo CD, showing how Argo CD re-evaluates the state of Kubernetes resources.

- Normal Refresh : If, and only if, the source has changed (e.g. a new commit or a new Helm chart version), the manifests will be re-rendered. A normal refresh happens every 3 minutes by default, and is requested by the application controller.

- Hard Refresh : A hard refresh invalidates the manifest cache for your application, forcing the manifests to be re-rendered no matter whether there was a change in the source or not.

## Prerequisites
- An operational Argo CD installation
- Access to a Kubernetes cluster with Argo CD installed
- A Git repository with Kubernetes manifests

## Git setup
**Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

## Steps

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune optison.

- [0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml
```


## Demonstrating Application Refresh and Hard Refresh

1. **Deploy the Application**:
   - Create and sync an Argo CD application with the repository.

2. **Refresh the Application**:
   - After deployment, modify the Kubernetes resources directly, like scaling the deployment using `kubectl`.
   - Command: `kubectl scale deployment/example-deployment --replicas=1 -n argocdappdemo`

3. **Perform a Refresh**:
   - Refresh the application in Argo CD:
     - Command: `argocd app get prunetestapp --refresh`

4. **Perform a Hard Refresh**:
   - For a more thorough update, perform a hard refresh:
     - Command: `argocd app get prunetestapp --hard-refresh`

## Visualization and Understanding

- Observe the Argo CD UI or CLI to see the application state updates after each refresh.
- Understand how Argo CD interacts with Kubernetes to maintain application states.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are set up to track your Git repository.
