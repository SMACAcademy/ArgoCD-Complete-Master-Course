
## Defining Applications with YAML

Create a YAML file that defines your ArgoCD application. Here's an example YAML with explanations:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: argo-application  # Name of your ArgoCD application
  namespace: argocd  # Namespace where ArgoCD is deployed
spec:
  project: default  # The ArgoCD project to associate with
  source:
    repoURL: https://github.com/SMACAcademy/argocd-example-apps.git  # Source Git repository
    targetRevision: HEAD  # Branch, tag, or commit to synchronize
    path: guestbook  # Directory in the repo containing the manifests
  destination: 
    server: https://kubernetes.default.svc  # Kubernetes cluster URL
    namespace: myapp  # Target namespace for deployment
  syncPolicy:
    syncOptions:
      - CreateNamespace=true  # ArgoCD will create the namespace if not present
    automated:
      selfHeal: true  # Automatic reconciliation if the state drifts
      prune: true  # Remove resources missing in the repository
```

- `CreateNamespace=true` allows ArgoCD to create the specified namespace if it does not already exist.
- `selfHeal` ensures that any manual changes made to the resources in the cluster are brought back to the state defined in Git.
- `prune` deletes resources in the cluster that are no longer present in the Git repository.

## Applying the YAML File

Once the YAML file is ready, apply it to your cluster with the following command:

```bash
kubectl apply -f application.yaml
```

This command creates the application as defined in the YAML file in ArgoCD, which then syncs the application state with the cluster. After running the command, ArgoCD will monitor the repository at the specified `repoURL` and path. Any changes pushed to the repository will be reflected in the Kubernetes cluster based on the sync policy defined.

## Delete the application

```bash
kubectl delete -f application.yaml
```
