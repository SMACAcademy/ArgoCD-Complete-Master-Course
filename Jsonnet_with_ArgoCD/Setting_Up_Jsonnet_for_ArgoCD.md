
# Setting Up Jsonnet for ArgoCD

This guide provides the steps to set up Jsonnet for ArgoCD, including writing Jsonnet templates, configuring ArgoCD to recognize Jsonnet files, and ensuring ArgoCD can sync these resources to your Kubernetes clusters.

## Step 1: Install Jsonnet

Jsonnet must be installed on your local development machine.

#### For macOS:
```sh
brew install jsonnet
```

#### For Linux (Debian/Ubuntu):
```sh
apt-get install jsonnet
```

#### For Windows:
Download the latest Jsonnet executable from the official [Jsonnet GitHub repository](https://github.com/google/jsonnet/releases) and add it to your PATH.

## Step 2: Write a Sample Jsonnet Template

Create a Jsonnet template for a Kubernetes Deployment. Save the following content into a file named `deployment.jsonnet`.

```jsonnet
local containerPort = 8080;

{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: 'sample-app',
  },
  spec: {
    replicas: 3,
    selector: {
      matchLabels: {
        app: 'sample-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'sample-app',
        },
      },
      spec: {
        containers: [
          {
            name: 'sample-app',
            image: 'nginx:1.19.0',
            ports: [
              {
                containerPort: containerPort,
              },
            ],
          },
        ],
      },
    },
  },
}
```

## Step 3: Convert Jsonnet Template to JSON/YAML

You can convert the Jsonnet template to JSON or YAML which ArgoCD can then apply to your Kubernetes cluster.

To convert to JSON, run:

```sh
jsonnet deployment.jsonnet -o deployment.json
```

To convert to YAML, you might need a tool like `jsonnet` and `yq`:

```sh
jsonnet deployment.jsonnet | yq e -P - > deployment.yaml
```

## Step 4: Set Up ArgoCD to Use Jsonnet

ArgoCD supports Jsonnet files natively. To use Jsonnet templates, configure your ArgoCD application manifest to use Jsonnet as the source.

Here is a sample `argocd-application.yaml` that specifies a Jsonnet file as the source:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sample-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://your-git-repository-url.git'
    targetRevision: HEAD
    path: path/to/your/jsonnet
    jsonnet: 
      extVars:
        - name: containerPort
          value: "8080"
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: 'default'
  syncPolicy:
    automated: {}
```

This manifest assumes you have a directory structure in your Git repository like this:

```
/path/to/your/jsonnet
|-- deployment.jsonnet
```

## Step 5: Apply the ArgoCD Application Manifest

Apply the `argocd-application.yaml` to your Kubernetes cluster where ArgoCD is running:

```sh
kubectl apply -f argocd-application.yaml
```

## Step 6: Sync Your Application

Now, you can sync your application in ArgoCD, either through the UI or using the CLI:

```sh
argocd app sync sample-app
```

## Step 7: Verify Deployment

Finally, check that the application has been deployed correctly:

```sh
kubectl get deployments
```

## Troubleshooting

If there are issues, use the ArgoCD UI or CLI to troubleshoot:

- Check the ArgoCD application status.
- Review the sync logs for any errors.
- Confirm that your Jsonnet file is correct and generates valid Kubernetes manifests.

By following these steps, you can set up Jsonnet for ArgoCD and begin using Jsonnet templates to manage your Kubernetes deployments in a more dynamic and modular fashion.
