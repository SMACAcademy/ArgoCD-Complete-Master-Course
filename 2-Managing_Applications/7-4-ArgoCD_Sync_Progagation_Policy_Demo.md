
# Demonstrating Propagation Policy in Argo CD

To demonstrate and visualize the `Propagation Policy` in Argo CD, follow these steps with sample files in a Kubernetes environment.

## Prerequisites

- **Kubernetes Cluster**: A running Kubernetes cluster is needed. Options include Minikube, kind, or a cloud-based Kubernetes service.
- **Argo CD Installation**: Argo CD must be installed in your cluster. Refer to the [official installation guide](https://argo-cd.readthedocs.io/en/stable/getting_started/).

## Sample Application Files

1. **Create a Git Repository**: Use a public GitHub repository to host your application configuration files.

2. **Sample Application Configuration**: Here's an example YAML file for a basic Kubernetes Deployment and Service.

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: sample-app
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: sample-app
     template:
       metadata:
         labels:
           app: sample-app
       spec:
         containers:
         - name: nginx
           image: nginx:1.19.4
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: sample-app-service
   spec:
     selector:
       app: sample-app
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

   Push this YAML to your Git repository.

## Steps to Visualize Propagation Policy

1. **Deploy the Application using Argo CD**:
   - Connect your Git repository to Argo CD.
   - Create an Argo CD application pointing to this repository.

2. **Observe the Initial Deployment**:
   - Ensure the application is successfully deployed in your Kubernetes cluster.

3. **Modify the Application Configuration for Pruning**:
   - Remove the Service definition from the YAML file and push the changes to your Git repository.

4. **Apply Different Propagation Policies**:
   - **Foreground**: Update Argo CD to use a foreground propagation policy and synchronize.
   - **Background**: Change to a background propagation policy and synchronize after restoring the Service.
   - **Orphan**: Use the orphan policy and synchronize.

5. **Visualization**:
   - Use `kubectl get` commands to observe resource states in your cluster.
   - Optionally, use the Kubernetes dashboard or Argo CD UI for visual observation.

Follow these steps to understand how each propagation policy affects resource management in Argo CD.
