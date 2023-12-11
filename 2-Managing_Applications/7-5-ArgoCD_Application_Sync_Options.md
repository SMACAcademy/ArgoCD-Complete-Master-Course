
# Argo CD Synchronization Options Demonstration

This guide provides sample files and commands to demonstrate various Argo CD synchronization options like `skip schema validation`, `prune last`, `respect ignore differences`, `apply out of sync only`, and `serverside apply`.

## Sample Kubernetes Application

Create two files in your Git repository:

1. **Deployment (deployment.yaml)**

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: demo
     template:
       metadata:
         labels:
           app: demo
       spec:
         containers:
         - name: nginx
           image: nginx:1.19.4
           ports:
           - containerPort: 80
   ```

2. **Service (service.yaml)**

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: demo-service
   spec:
     selector:
       app: demo
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

## Argo CD Commands for Different Options

1. **Skip Schema Validation**:
   - Command: `argocd app sync APP_NAME --skip-schema-validation`

2. **Prune Last**:
   - Command: `argocd app sync APP_NAME --prune-last`

3. **Respect Ignore Differences**:
   - Command: `argocd app sync APP_NAME --respect-ignore-differences`

4. **Apply Out of Sync Only**:
   - Command: `argocd app sync APP_NAME --sync-option OutOfSyncOnly=true`

5. **Serverside Apply**:
   - Command: `argocd app sync APP_NAME --server-side`

## Visualization and Understanding

- Monitor the application in Argo CD after running each command.
- Use `kubectl` commands to see the state of Kubernetes resources.
- Compare the states to understand the impact of each synchronization option.

## Note

- Replace `APP_NAME` with the actual name of your Argo CD application.
- Ensure your Kubernetes cluster and Argo CD are set up to track the repository containing these files.
