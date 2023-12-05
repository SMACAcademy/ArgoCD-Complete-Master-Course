
# Using Jsonnet Bundles with ArgoCD

This document provides a demonstration of how to use Jsonnet bundles with ArgoCD, including sample files, commands, and steps.

## 1. Create a Jsonnet Bundle

- **Jsonnet File (`deployment.jsonnet`)**

    ```jsonnet
    {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'my-app',
      },
      spec: {
        replicas: 1,
        selector: {
          matchLabels: {
            app: 'my-app',
          },
        },
        template: {
          metadata: {
            labels: {
              app: 'my-app',
            },
          },
          spec: {
            containers: [{
              name: 'nginx',
              image: 'nginx:latest',
            }],
          },
        },
      },
    }
    ```

- **Jsonnet Bundle Dependencies (`jsonnetfile.json`)**

    ```json
    {
      "dependencies": []
    }
    ```

## 2. Set Up a Jsonnet Environment

- Install Jsonnet and Jsonnet Bundler.
- Initialize a Jsonnet bundle:

    ```bash
    jb init
    ```

## 3. Create an ArgoCD Application for the Bundle

- **ArgoCD Application YAML (`argo-app.yaml`)**

    ```yaml
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: my-jsonnet-bundle-app
    spec:
      project: default
      source:
        repoURL: 'https://github.com/your-repo.git'
        targetRevision: HEAD
        path: path-to-your-jsonnet-bundle
        directory:
          recurse: true
          jsonnet: {}
      destination:
        server: 'https://kubernetes.default.svc'
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
    ```

## 4. Commit and Push to Your Git Repository

- Use Git commands to push your changes.

## 5. Apply the ArgoCD Application

- Apply the ArgoCD application manifest:

    ```bash
    kubectl apply -f argo-app.yaml
    ```

## 6. Observe the Deployment in ArgoCD

- Monitor the deployment in ArgoCD.
