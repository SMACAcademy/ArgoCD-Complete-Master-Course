
# Auditing and Tracking Changes in Projects in ArgoCD

This guide provides steps, commands, and sample files to demonstrate auditing and tracking changes in projects managed by ArgoCD.

## 1. Understanding Auditing and Tracking in ArgoCD

- **Auditing**: Involves keeping records of changes, operations, and deployments in ArgoCD.
- **Tracking Changes**: Refers to monitoring updates in the Git repository that ArgoCD uses to sync Kubernetes manifests.

## 2. Pre-requisites

- A running ArgoCD instance in your Kubernetes cluster.
- Access to a Git repository with Kubernetes manifests.

## 3. Sample Git Repository Structure

```plaintext
/my-k8s-configs
|-- /apps
|   |-- app1.yaml
|   |-- app2.yaml
|-- /environments
    |-- /dev
    |   |-- app1.yaml
    |   |-- app2.yaml
    |-- /prod
        |-- app1.yaml
        |-- app2.yaml
```

## 4. Demonstration Steps

### Step 1: Setting Up ArgoCD Applications

- Configure applications in ArgoCD to point to the paths in your Git repository.
- Example: An application `app1` in `dev` environment will track the path `/environments/dev/app1.yaml`.

### Step 2: Committing Changes in Git

- Make and commit changes:
  ```bash
  git add environments/dev/app1.yaml
  git commit -m "Update app1 configuration"
  git push origin main
  ```

### Step 3: ArgoCD Syncing and Tracking

- ArgoCD automatically detects changes. To manually sync:
  ```bash
  argocd app sync app1
  ```

### Step 4: Auditing Changes

- View the history of syncs in ArgoCD CLI or UI.
- CLI command for history:
  ```bash
  argocd app history app1
  ```

### Step 5: Using ArgoCD Events for Detailed Auditing

- Use Kubernetes events for detailed audit trail:
  ```bash
  kubectl get events --namespace argocd | grep app1
  ```

### Step 6: Additional Tools for Auditing (Optional)

- Set up Prometheus, Grafana, and external logging tools for comprehensive auditing.

## 5. Best Practices

- Regularly check Git commit history.
- Ensure ArgoCD has necessary RBAC permissions.
- Integrate with external audit and compliance tools for larger projects.
