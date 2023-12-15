
# Demonstrating Application App Diff in Argo CD

This guide provides sample files and commands to demonstrate the `app diff` feature in Argo CD, which compares the desired state in the Git repository with the current state in the Kubernetes cluster.

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

1. **Command:**
  ```bash
  kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml
  ```


2. **Modify Kubernetes Resources Directly**:
   - After deployment, change the Kubernetes resources manually:
     - Command: `kubectl set image deployment/example-deployment nginx=nginx:1.19.6 -n argocdappdemo` 

3. **Perform an App Diff**:
   - Use Argo CD CLI to see the differences:
     - Command: `argocd app diff prunetestapp`

## Visualization and Understanding

- The `app diff` command output shows the differences between the Git repository configuration and the current state in the Kubernetes cluster.
- It's crucial for identifying and correcting state drifts.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are set up to track your Git repository.
