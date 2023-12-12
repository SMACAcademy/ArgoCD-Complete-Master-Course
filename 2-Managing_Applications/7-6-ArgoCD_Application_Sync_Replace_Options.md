
# Demonstrating the Replace Sync Option in Argo CD

This guide provides sample files and commands to demonstrate the `replace` sync option in Argo CD, useful for forcefully replacing existing resources in the cluster with those defined in your Git repository.

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

3. **Apply Replace Sync Option**:
   - Use the command: `argocd app set prunetestapp --sync-option Replace=true`
   - Sync Application using `argocd app sync prunetestapp`

4. **Observe the Changes**:
   - Use `kubectl describe deployment example-deployment -n argocdappdemo` to see the changes.
   - The deployment will be entirely replaced, not just updated.

## Visualization and Understanding

- Compare the deployment state before and after using the replace option.
- This demonstrates the impact of forcefully aligning cluster resources with Git repository definitions.

## Note

- Ensure your Kubernetes cluster and Argo CD are configured to track your Git repository.
