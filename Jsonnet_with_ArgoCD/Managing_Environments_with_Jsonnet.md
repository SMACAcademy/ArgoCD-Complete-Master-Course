# Managing Environments with Jsonnet in ArgoCD

This document provides a demonstration of how to manage different Kubernetes environments (development, staging, production) using Jsonnet in ArgoCD.

## 1. Create Base Jsonnet Template

- **Base Template (`base.jsonnet`):**

    ```jsonnet
    local container(image) = {
      name: 'my-app',
      image: image,
      ports: [{ containerPort: 80 }],
    };

    {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'my-app',
      },
      spec: {
        replicas: 1,
        selector: { matchLabels: { app: 'my-app' } },
        template: {
          metadata: { labels: { app: 'my-app' } },
          spec: { containers: [container($.image)] },
        },
      },
    }
    ```

## 2. Create Environment-specific Jsonnet Files

- **Development (`dev.jsonnet`):**

    ```jsonnet
    local base = import 'base.jsonnet';

    base {
      image: 'my-app:dev'
    }
    ```

- **Staging (`staging.jsonnet`):**

    ```jsonnet
    local base = import 'base.jsonnet';

    base {
      image: 'my-app:staging'
    }
    ```

- **Production (`prod.jsonnet`):**

    ```jsonnet
    local base = import 'base.jsonnet';

    base {
      image: 'my-app:latest'
    }
    ```

## 3. Compile Jsonnet Files

- Compile each file to a Kubernetes manifest:

    ```bash
    jsonnet dev.jsonnet -o dev-deployment.yaml
    jsonnet staging.jsonnet -o staging-deployment.yaml
    jsonnet prod.jsonnet -o prod-deployment.yaml
    ```

## 4. Create ArgoCD Applications for Each Environment

- **Example for Development Environment (`argo-dev-app.yaml`):**

    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: my-app-dev
    spec:
      project: default
      source:
        repoURL: 'https://github.com/your-repo.git'
        targetRevision: HEAD
        path: path-to-your-jsonnet-files
        jsonnet: {}
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: dev-namespace
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
    ```

- Repeat for staging and production with appropriate changes.

## 5. Commit and Push to Your Git Repository

- Use Git to commit and push your changes.

## 6. Apply the ArgoCD Applications

- Apply each ArgoCD application manifest:

    ```bash
    kubectl apply -f argo-dev-app.yaml
    kubectl apply -f argo-staging-app.yaml
    kubectl apply -f argo-prod-app.yaml
    ```

## 7. Observe the Deployments in ArgoCD

- Monitor deployments in ArgoCD for each environment.