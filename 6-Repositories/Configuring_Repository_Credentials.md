
# Configuring Repository Credentials in Argo CD

This guide provides a demonstration of configuring repository credentials in Argo CD, including sample files, commands, and detailed explanations.

## 1. Understanding Repository Credentials
Repository credentials in Argo CD are used for accessing private repositories or repositories that require authentication.

## 2. Prerequisites
- Argo CD installed on a Kubernetes cluster.
- Access to Argo CD command-line interface and web UI.
- A private Git repository with Kubernetes manifests.

## 3. Generating SSH Keys (If Using SSH)
Generate an SSH key pair and add the public key to your Git repository's access settings.

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## 4. Storing Credentials in Argo CD

### A. Using the Argo CD Web UI
1. **Access Argo CD UI** and navigate to 'Settings' > 'Repositories'.
2. **Add Repository** with the required authentication details.

### B. Using a Secret
Create a Kubernetes Secret with the repository credentials.

#### For HTTPS:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-repo-secret
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: https://github.com/yourusername/your-repo.git
  username: <username>
  password: <password_or_token>
```

#### For SSH:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-repo-secret
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: git@github.com:yourusername/your-repo.git
  sshPrivateKey: |
    -----BEGIN RSA PRIVATE KEY-----
    ...
    -----END RSA PRIVATE KEY-----
```

Apply the Secret with `kubectl apply -f <secret-file>.yaml`.

## 5. Syncing Applications
Once the repository is added, create and sync applications in Argo CD using the configured credentials.

## 6. Best Practices and Security
- Prefer SSH keys over username/password.
- Limit repository access scope.
- Regularly update credentials.

## 7. Troubleshooting
Check credentials correctness, repository access permissions, and Argo CD logs for errors.

## Conclusion
Configuring repository credentials in Argo CD is crucial for private repository access. Refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/) for advanced configurations and troubleshooting.
