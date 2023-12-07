
# Jsonnet and ArgoCD Application Sets in ArgoCD

## Step 1: Understanding Jsonnet

Jsonnet is a domain-specific language for defining JSON data, used in ArgoCD to template Kubernetes manifests.

### Sample Jsonnet File: `app.jsonnet`
```jsonnet
{
  kind: 'Application',
  apiVersion: 'argoproj.io/v1alpha1',
  metadata: {
    name: std.extVar('name'),
    namespace: 'argocd',
  },
  spec: {
    project: 'default',
    source: {
      repoURL: 'https://github.com/your/repo.git',
      targetRevision: 'HEAD',
      path: std.extVar('path'),
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: std.extVar('namespace'),
    },
  },
}
```

## Step 2: Creating ArgoCD Application Set

ApplicationSets allow the dynamic generation of ArgoCD Applications based on a template.

### Sample ApplicationSet File: `appset.yaml`
```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: example-appset
  namespace: argocd
spec:
  generators:
    - list:
        elements:
          - name: app1
            path: path/to/app1
            namespace: dev
          - name: app2
            path: path/to/app2
            namespace: prod
  template:
    spec:
      project: default
      source:
        repoURL: https://github.com/your/repo.git
        targetRevision: HEAD
        path: '{{path}}'
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: '{{namespace}}'
```

## Step 3: Using Jsonnet with ApplicationSets

Jsonnet can be used to template parts of your ApplicationSet.

### Jsonnet Command
```bash
jsonnet -V name=app1 -V path=path/to/app1 -V namespace=dev app.jsonnet > app1.yaml
jsonnet -V name=app2 -V path=path/to/app2 -V namespace=prod app.jsonnet > app2.yaml
```

## Step 4: Applying the ApplicationSet

Use `kubectl` to apply the ApplicationSet in ArgoCD.

### Command to Apply ApplicationSet
```bash
kubectl apply -f appset.yaml
```
