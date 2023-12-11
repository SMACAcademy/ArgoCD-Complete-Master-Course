
# Demonstrating Application Refresh and Hard Refresh in Argo CD

This guide provides sample files and commands to demonstrate the `refresh` and `hard refresh` options in Argo CD, showing how Argo CD re-evaluates the state of Kubernetes resources.

## Sample Kubernetes Application

Create a simple application in your Git repository:

1. **Deployment (deployment.yaml)**
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: refresh-demo-app
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: refresh-demo
     template:
       metadata:
         labels:
           app: refresh-demo
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
     name: refresh-demo-service
   spec:
     selector:
       app: refresh-demo
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

## Demonstrating Application Refresh and Hard Refresh

1. **Deploy the Application**:
   - Create and sync an Argo CD application with the repository.

2. **Refresh the Application**:
   - After deployment, modify the Kubernetes resources directly, like scaling the deployment using `kubectl`.
   - Command: `kubectl scale deployment refresh-demo-app --replicas=2`

3. **Perform a Refresh**:
   - Refresh the application in Argo CD:
     - Command: `argocd app refresh APP_NAME`

4. **Perform a Hard Refresh**:
   - For a more thorough update, perform a hard refresh:
     - Command: `argocd app refresh APP_NAME --hard`

## Visualization and Understanding

- Observe the Argo CD UI or CLI to see the application state updates after each refresh.
- Understand how Argo CD interacts with Kubernetes to maintain application states.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your Kubernetes cluster and Argo CD are set up to track your Git repository.
