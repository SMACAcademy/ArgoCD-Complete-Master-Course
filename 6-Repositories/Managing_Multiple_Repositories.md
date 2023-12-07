
# Managing Multiple Repositories in Argo CD

This guide provides an overview of managing multiple repositories in Argo CD, including necessary sample files, commands, and detailed instructions.

## 1. Understanding Multiple Repositories in Argo CD
Manage multiple repositories in Argo CD to separate different applications, environments, or configurations.

## 2. Prerequisites
- Argo CD installed in your Kubernetes cluster.
- Access to the Argo CD CLI and UI.
- Two or more Git repositories with Kubernetes manifests.

## 3. Adding Multiple Repositories

### A. Using the Argo CD Web UI
1. **Access Argo CD UI** and navigate to 'Settings' > 'Repositories'.
2. **Add Each Repository** with the URL and credentials.

### B. Using the CLI
Add repositories using the `argocd repo add` command.

```bash
argocd repo add https://github.com/user/repo1.git --username <username> --password <password>
argocd repo add https://github.com/user/repo2.git --username <username> --password <password>
```

## 4. Sample Application Manifests
Create Kubernetes manifests in each repository. Example for `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-from-repo1
  labels:
    app: app-from-repo1
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app-from-repo1
  template:
    metadata:
      labels:
        app: app-from-repo1
    spec:
      containers:
      - name: nginx
        image: nginx:latest
```

## 5. Creating Applications for Each Repository
Create an application in Argo CD for each repository with the specific repository URL and manifest path.

## 6. Syncing Applications
Sync each application based on your configuration.

## 7. Updating and Managing Applications
Automatically detect and apply changes when updating application manifests.

## 8. Best Practices
- Use separate repositories for different environments or application types.
- Ensure proper access control and security.
- Maintain organized and consistent Kubernetes manifests.

## 9. Troubleshooting
Common issues include connectivity problems, permission errors, and sync issues.

## Conclusion
Manage multiple repositories in Argo CD for a modular and scalable approach to Kubernetes application deployment. Refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/) for more details.
