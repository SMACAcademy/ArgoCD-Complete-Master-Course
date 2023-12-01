
# Argo CD Self-Healing Feature Demonstration

## Sample Files

### 1. Deployment Manifest (`nginx-deployment.yaml`)

This is a simple Kubernetes deployment manifest for an Nginx server:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

### 2. Argo CD Application Manifest (`argo-app.yaml`)

This defines the Argo CD application that points to the repository containing your Kubernetes manifests:

[0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app.yaml](../0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app.yaml)

## Steps and Commands

1. **Commit and Push Your Files to Git Repository**:
   - Place these files in your Git repository and push them.

2. **Install Argo CD in Your Cluster**:
   - Follow the official documentation: [Argo CD Documentation](https://argo-cd.readthedocs.io/en/stable/getting_started/)

3. **Create Argo CD Application**:
   - Apply the Argo CD Application manifest:
     ```bash
     kubectl apply -f argo-app.yaml -n argocd
     ```

4. **Simulate a Manual Change in the Cluster**:
   - Change the number of replicas:
     ```bash
     kubectl scale deployment/nginx-deployment --replicas=1
     ```

5. **Observe Argo CD's Self-Healing Action**:
   - Argo CD will detect the deviation and revert the changes.

6. **Verify the Reversion**:
   - Check the number of replicas:
     ```bash
     kubectl get deployment/nginx-deployment
     ```
   - The deployment should be back to 2 replicas.

## Monitoring through Argo CD UI

- Use Argo CD's web UI to monitor these changes.
