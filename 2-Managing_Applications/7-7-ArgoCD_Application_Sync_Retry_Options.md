
# Demonstrating the Retry Sync Option in Argo CD

This guide provides sample files and commands to demonstrate the `retry` sync option in Argo CD, useful for reattempting deployments after transient failures or issues.

## Git setup
**Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

## Steps

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune optison.

- [0-Demo_Files/Sync_Retry_Apps/argo-app-sync-retry.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Sync_Retry_Apps/argo-app-sync-retry.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Sync_Retry_Apps/argo-app-sync-retry.yaml
```




2. **Correct the Deployment**:
   - Update `deployment.yaml` to a correct image, like `nginx:1.19.4` .
   - Commit and push the changes.

3. **Observe the Changes**:
   - Use `kubectl describe deployment example-deployment -n argocdappdemo-retry` to see the successful deployment after retry.

## Visualization and Understanding

- This demonstrates how Argo CD handles deployment failures and the effectiveness of the retry option for transient issues.

## Note

- Ensure your Kubernetes cluster and Argo CD are configured to track your Git repository.
