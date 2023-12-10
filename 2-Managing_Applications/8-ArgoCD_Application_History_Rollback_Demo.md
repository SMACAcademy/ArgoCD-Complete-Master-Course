
# ArgoCD History and Rollback Demonstration Steps
## Prerequisites
- An operational Argo CD installation
- Access to a Kubernetes cluster with Argo CD installed
- A Git repository with Kubernetes manifests

## Git setup
**Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

This guide demonstrates how to use the History and Rollback features in ArgoCD.

## 1. Initial Setup

### Deploy an Application
[0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-history-rollback.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-history-rollback.yaml)

- Apply with `kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-history-rollback.yaml`.

 ```bash

kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-history-rollback.yaml

 ```

## 2. Make Changes to the Application

### a. Update the Application
- Make changes to your application's repository.

### b. Sync the Application
- Sync in ArgoCD:
  ```bash
  argocd app sync history-rollback-demo
  ```

## 3. View History

### a. Check Revision History
- View history in ArgoCD:
  ```bash
  argocd app history history-rollback-demo
  ```

## 4. Perform Rollback

### a. Rollback to a Previous Revision
- Identify the revision number from the history.
- Rollback command:
  ```bash
  argocd app rollback history-rollback-demo [REVISION_NUMBER]
  ```

## 5. Verify Rollback

### a. Confirm Rollback Success
- Check the application's status:
  ```bash
  argocd app get history-rollback-demo
  ```
- Verify in the ArgoCD UI.

**Note:** Replace `[REVISION_NUMBsER]` with the actual revision number you wish to rollback to. Modify the `application.yaml` and repository URL as needed.
