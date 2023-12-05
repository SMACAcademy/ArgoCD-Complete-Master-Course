
# Parameterizing Jsonnet Templates in ArgoCD

This document demonstrates the process of parameterizing Jsonnet templates for Kubernetes resources in ArgoCD.

## 1. Create a Jsonnet Template for Kubernetes Resources

Save this as `deployment.jsonnet`:

```jsonnet
local appName = std.extVar('appName');
local image = std.extVar('image');
local replicas = std.extVar('replicas');

{
  deployment: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: appName,
    },
    spec: {
      replicas: replicas,
      selector: {
        matchLabels: {
          app: appName,
        },
      },
      template: {
        metadata: {
          labels: {
            app: appName,
          },
        },
        spec: {
          containers: [
            {
              name: appName,
              image: image,
            },
          ],
        },
      },
    },
  },

  service: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: appName,
    },
    spec: {
      selector: {
        app: appName,
      },
      ports: [
        {
          protocol: 'TCP',
          port: 80,
          targetPort: 8080,
        },
      ],
    },
  },
}
```

## 2. Parameterize the Jsonnet Template

Create `params.libsonnet`:

```jsonnet
{
  appName: 'myapp',
  image: 'nginx:latest',
  replicas: 3,
}
```

## 3. Compile the Jsonnet Template

Run:

```bash
jsonnet -J . -m . deployment.jsonnet --ext-code-file params=params.libsonnet
```

## 4. Create an ArgoCD Application

Save as `argo-app.yaml`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-jsonnet-app
spec:
  project: default
  source:
    repoURL: 'https://github.com/your-repo.git'
    targetRevision: HEAD
    path: path-to-your-jsonnet-files
    jsonnet:
      extVars:
        - name: appName
          value: myapp
        - name: image
          value: nginx:latest
        - name: replicas
          value: "3"
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## 5. Apply the ArgoCD Application

Execute:

```bash
kubectl apply -f argo-app.yaml
```

## 6. Observe the Deployment in ArgoCD

ArgoCD will compile and deploy the resources defined in the Jsonnet template.
