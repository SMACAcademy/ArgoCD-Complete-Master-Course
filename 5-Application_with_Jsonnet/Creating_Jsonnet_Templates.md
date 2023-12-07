### 1. **Install ArgoCD**

- First, you need to have ArgoCD installed in your Kubernetes cluster.

  [ArgoCD Installation and Setup](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/tree/main/1-Installation_and_Setup)

### 2. **Set Up Jsonnet**

- Ensure Jsonnet is installed on your local machine. You can download it from the [official Jsonnet GitHub repository](https://github.com/google/jsonnet).

### 3. **Create a Jsonnet Template**

- Create a file named `deployment.jsonnet` which will be your Jsonnet template for a Kubernetes deployment.
- Here's an example of what it might look like:
  
```jsonnet

local container = function(name, image) {
  name: name,
  image: image,
  ports: [{containerPort: 80}],
};

{
  deployment: {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'my-deployment',
    },
    spec: {
      replicas: 3,
      template: {
        metadata: {
          labels: {app: 'myapp'},
        },
        spec: {
          containers: [
            container('my-container', 'nginx'),
          ],
        },
      },
    },
  },
}

```

### 4. **Convert Jsonnet Template to Kubernetes Manifest**

- Use the Jsonnet command-line tool to convert the Jsonnet template into a YAML file.

```bash
jsonnet deployment.jsonnet > deployment.yaml

```
### 5. **Create ArgoCD Application**

- Write an ArgoCD application manifest that references the Jsonnet file. Create a file named `argocd-application.yaml` with the following content:```yaml

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: jsonnet-demo
  namespace: argocd
spec:
  project: default
  source:
    repoURL: '
'
    targetRevision: HEAD
    path: '
'
    jsonnet: {}
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: 'default'

```

### 6. **Apply the ArgoCD Application**

- Apply the ArgoCD application manifest to your cluster.

```bash
kubectl apply -f argocd-application.yaml

```
### 7. **Access ArgoCD UI**

- Use port-forwarding to access the ArgoCD UI and check the status of your application.

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443

```

- Access the UI by navigating to `http://localhost:8080` in your web browser.

### 8. **Verify Deployment**

- Verify that the application has been deployed correctly in Kubernetes.

```bash
kubectl get deployments

```