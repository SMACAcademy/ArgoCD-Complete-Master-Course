
# ApplicationSet in Argo CD Guide

## Step-by-Step Guide for ApplicationSet in Argo CD

This guide assumes Argo CD is already installed in your Kubernetes cluster.

### Step 1: Prepare the ApplicationSet Manifest

Create a YAML file for the ApplicationSet. This file defines how your applications will be deployed across different clusters or environments. Here's an example of the `applicationset.yaml`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: example-applicationset
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - cluster: dev
            url: https://dev-cluster-api-server
          - cluster: prod
            url: https://prod-cluster-api-server
  template:
    metadata:
      name: '{{cluster}}-guestbook'
    spec:
      project: default
      source:
        repoURL: 'https://github.com/argoproj/argocd-example-apps.git'
        targetRevision: HEAD
        path: guestbook
      destination:
        server: '{{url}}'
        namespace: guestbook
```

In this example:
- The `generators` section creates parameters (`cluster` and `url`) for each application instance.
- The `template` section defines the base Application resource, where `{{cluster}}` and `{{url}}` are replaced with the corresponding values from the `elements`.

### Step 2: Deploy the ApplicationSet

Deploy the ApplicationSet to your Argo CD environment:

```sh
kubectl apply -f applicationset.yaml
```

This command creates an ApplicationSet resource in the Argo CD namespace.

### Step 3: Verify Deployment

Check the status of the ApplicationSet to ensure it's deployed correctly:

```sh
kubectl get applicationset -n argocd
```

### Step 4: Access the Deployed Applications

Access the deployed applications in the Argo CD dashboard. Each element from the `elements` list should result in a separate Application in Argo CD, corresponding to each environment or cluster.

### Step 5: Update the ApplicationSet (If Needed)

To modify the ApplicationSet (e.g., add more environments or change the source repository), update the `applicationset.yaml` file and reapply it:

```sh
kubectl apply -f applicationset.yaml
```

## Additional Notes

- **Cluster Access:** Ensure Argo CD can access the Kubernetes API servers for the specified clusters.
- **Customization:** The `applicationset.yaml` can be customized to fit various deployment strategies (e.g., different namespaces, projects, or even different applications).
- **Security:** Make sure Argo CD has the necessary RBAC permissions for all operations in the target clusters.

By following these steps, you can efficiently manage multiple applications across various environments or clusters using ApplicationSet in Argo CD.
