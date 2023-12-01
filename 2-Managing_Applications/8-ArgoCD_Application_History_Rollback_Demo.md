
# ArgoCD History and Rollback Demonstration Steps

This guide demonstrates how to use the History and Rollback features in ArgoCD.

## 1. Initial Setup

### Deploy an Application
- Example `application.yaml` file:
  ```yaml
  apiVersion: argoproj.io/v1alpha1
  kind: Application
  metadata:
    name: hello-world
    namespace: argocd
  spec:
    project: default
    source:
      repoURL: 'https://github.com/your-repository/hello-world.git'
      targetRevision: HEAD
      path: k8s-manifests
    destination:
      server: 'https://kubernetes.default.svc'
      namespace: hello-world
  ```
- Apply with `kubectl apply -f application.yaml`.

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
