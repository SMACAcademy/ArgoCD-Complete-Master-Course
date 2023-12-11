
# Demonstrating Application App Diff in Argo CD

This guide provides sample files and commands to demonstrate the `app diff` feature in Argo CD, which compares the desired state in the Git repository with the current state in the Kubernetes cluster.

## Sample Kubernetes Application

Create a simple application in your Git repository:

1. **Deployment (deployment.yaml)**
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: diff-demo-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: diff-demo
     template:
       metadata:
         labels:
           app: diff-demo
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
     name: diff-demo-service
   spec:
     selector:
       app: diff-demo
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

## Demonstrating Application App Diff

1. **Deploy the Application**:
   - Create and sync an Argo CD application with the repository.

2. **Modify Kubernetes Resources Directly**:
   - After deployment, change the Kubernetes resources manually:
     - Command: `kubectl set image deployment/diff-demo-app nginx=nginx:1.19.6`

3. **Perform an App Diff**:
   - Use Argo CD CLI to see the differences:
     - Command: `argocd app diff APP_NAME`

## Visualization and Understanding

- The `app diff` command output shows the differences between the Git repository configuration and the current state in the Kubernetes cluster.
- It's crucial for identifying and correcting state drifts.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are set up to track your Git repository.
