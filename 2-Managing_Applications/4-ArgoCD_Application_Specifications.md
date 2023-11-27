
# ArgoCD Application Specifications

An ArgoCD Application Specification defines the deployment and management parameters for an application in a Kubernetes cluster. The specification includes several key elements:

## Metadata

Includes the application's name, namespace, and labels, along with finalizers to control deletion behavior.

```yaml
metadata:
  name: guestbook
  namespace: argocd
  labels:
    app.kubernetes.io/name: guestbook
  finalizers:
    - resources-finalizer.argocd.argoproj.io
```

## Source

Defines the location and specifics of the manifests, such as a Git repository.

```yaml
source:
  repoURL: https://github.com/argoproj/argocd-example-apps.git
  targetRevision: HEAD
  path: guestbook
```

## Destination

Specifies where the application should be deployed within the cluster.

```yaml
destination:
  server: https://kubernetes.default.svc
  namespace: guestbook
```

## Sync Policy

Configures synchronization behavior, including options for pruning and self-healing.

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

## Ignore Differences

Lists resource fields that should be ignored during synchronization.

```yaml
ignoreDifferences:
  - group: apps
    kind: Deployment
    jsonPointers:
      - /spec/replicas
```

## Tool-specific Configuration

Additional configurations for tools like Helm or Kustomize.

```yaml
helm:
  parameters:
    - name: image.tag
      value: v1.0.1
kustomize:
  namePrefix: prod-
```

## Health Checks

Defines custom health checks for resources to monitor the application's state.

Each section can be expanded with details specific to your deployment and applied to ArgoCD with `kubectl apply -f application.yaml`. Monitoring can be done via ArgoCD CLI or UI.
