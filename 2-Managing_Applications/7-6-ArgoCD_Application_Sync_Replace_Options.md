
# Demonstrating the Replace Sync Option in Argo CD

This guide provides sample files and commands to demonstrate the `replace` sync option in Argo CD, useful for forcefully replacing existing resources in the cluster with those defined in your Git repository.

## Sample Kubernetes Application

Create a Kubernetes deployment and service in your Git repository:

1. **Deployment (deployment.yaml)**

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: demo-app
     template:
       metadata:
         labels:
           app: demo-app
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
       app: demo-app
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

## Demonstrating the Replace Sync Option

1. **Initial Deployment**:
   - Create an Argo CD application pointing to the repository and sync it.

2. **Change the Deployment**:
   - Modify `deployment.yaml`, like changing replicas from `1` to `2`.
   - Commit and push the change.

3. **Apply Replace Sync Option**:
   - Use the command: `argocd app sync APP_NAME --sync-option Replace=true`

4. **Observe the Changes**:
   - Use `kubectl get deployment demo-app` to see the changes.
   - The deployment will be entirely replaced, not just updated.

## Visualization and Understanding

- Compare the deployment state before and after using the replace option.
- This demonstrates the impact of forcefully aligning cluster resources with Git repository definitions.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are configured to track your Git repository.
