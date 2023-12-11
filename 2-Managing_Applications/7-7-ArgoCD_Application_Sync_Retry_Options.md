
# Demonstrating the Retry Sync Option in Argo CD

This guide provides sample files and commands to demonstrate the `retry` sync option in Argo CD, useful for reattempting deployments after transient failures or issues.

## Sample Kubernetes Application

Create a deployment in your Git repository designed to fail initially:

1. **Deployment (deployment.yaml)**

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app-retry
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: demo-app-retry
     template:
       metadata:
         labels:
           app: demo-app-retry
       spec:
         containers:
         - name: nginx
           # Using a non-existent or wrong image to cause initial failure
           image: nginx:non-existent
           ports:
           - containerPort: 80
   ```

## Demonstrating the Retry Sync Option

1. **Initial Deployment with Failure**:
   - Deploy the resource using Argo CD, which will fail due to the incorrect Docker image.

2. **Correct the Deployment**:
   - Update `deployment.yaml` to a correct image, like `nginx:1.19.4`.
   - Commit and push the changes.

3. **Apply Retry Sync Option**:
   - Use the command: `argocd app sync APP_NAME --retry`

4. **Observe the Changes**:
   - Use `kubectl get deployment demo-app-retry` to see the successful deployment after retry.

## Visualization and Understanding

- This demonstrates how Argo CD handles deployment failures and the effectiveness of the retry option for transient issues.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are configured to track your Git repository.
