
# Adding a New Cluster to Argo CD

To add a new cluster to Argo CD, follow these steps:

## 1. Install Argo CD CLI
Ensure the Argo CD command line tool is installed on your local machine. If not installed, download it from the [Argo CD releases page](https://github.com/argoproj/argo-cd/releases).

## 2. Log in to Argo CD
Use the Argo CD CLI to log in to your Argo CD server.
```bash
argocd login <ARGOCD_SERVER>
```
Replace `<ARGOCD_SERVER>` with your Argo CD server's address.

## 3. Get Access Credentials for the New Cluster
Ensure you have access credentials (kubeconfig) for the cluster you want to add. Obtain these from your cloud provider's CLI tools or web consoles.

## 4. Add the Cluster to Argo CD
Use `argocd cluster add` with the name of the context from your kubeconfig file.
```bash
argocd cluster add <CONTEXT_NAME>
```
Replace `<CONTEXT_NAME>` with your cluster context's name. You can find context names by running `kubectl config get-contexts`.

## 5. Verify the Cluster is Added
After adding, verify the cluster is connected to Argo CD.
```bash
argocd cluster list
```

## 6. Set Up RBAC Rules (Optional)
Set up specific RBAC rules in Argo CD for the new cluster as required.

### Notes
- `argocd cluster add` modifies the kubeconfig of the Argo CD server.
- Ensure the Argo CD server can access the Kubernetes API server of the new cluster.
- In secure or private networks, additional steps may be required.
- Check compatibility between Argo CD and the Kubernetes version of the new cluster.
- For issues or specific instructions, refer to the Argo CD documentation or your Kubernetes provider.
