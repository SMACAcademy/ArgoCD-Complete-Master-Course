
# Demonstrating Orphaned Resources Monitoring in Argo CD

This guide provides sample files and commands to demonstrate the Orphaned Resources Monitoring feature in Argo CD, which helps identify resources in the Kubernetes cluster that are not defined in the Git repository.

## Sample Kubernetes Application

Set up a simple application in your Git repository:

1. **Deployment (deployment.yaml)**
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: orphan-demo-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: orphan-demo
     template:
       metadata:
         labels:
           app: orphan-demo
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
     name: orphan-demo-service
   spec:
     selector:
       app: orphan-demo
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

## Demonstrating Orphaned Resources Monitoring

1. **Deploy the Application using Argo CD**:
   - Create an Argo CD application pointing to the repository.
   - Sync the application to deploy the resources.

2. **Orphan a Resource**:
   - Remove the `service.yaml` file from your Git repository and push the changes.
   - Or set the `propagationPolicy` to `orphan` for the service and sync.

3. **Monitor Orphaned Resources in Argo CD**:
   - After syncing, Argo CD will detect the service as orphaned.
   - Use the Argo CD UI or CLI (`argocd app get APP_NAME`) to observe the orphaned resources.

## Visualization and Understanding

- Observe the application in Argo CD to see how it identifies orphaned resources.
- This helps understand the management of orphaned resources in Kubernetes clusters.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are set up to track your Git repository.
