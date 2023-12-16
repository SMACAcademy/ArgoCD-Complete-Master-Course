
# Introduction to Repositories in Argo CD

This guide provides a demonstration of using repositories in Argo CD, including sample files, commands, and details to understand the concept.

## 1. Setting Up the Environment
Ensure you have the following prerequisites:
- A Kubernetes cluster (e.g., minikube, kind, or a cloud-based Kubernetes service).
- `kubectl` installed and configured to interact with your cluster.
- Argo CD installed in your Kubernetes cluster. You can follow the [official installation guide](https://argo-cd.readthedocs.io/en/stable/getting_started/).

## 2. Creating a Sample Application Repository
You'll need a Git repository with Kubernetes manifests. Here's how to set it up:

1. **Create a Git Repository**: Use a service like GitHub, GitLab, or Bitbucket to create a new repository.

2. **Add Kubernetes Manifests**: Create a sample deployment manifest `deployment.yaml`. Here's a basic example:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: sample-app
     labels:
       app: sample-app
   spec:
     replicas: 1
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
           image: nginx:latest
   ```

3. **Commit and Push**: Add the file to your repository and push the changes.


## 3. Adding a Repository in Argo CD
1. **Login to Argo CD**: Use the default admin account (password can be retrieved from Kubernetes secret).

2. **Add Your Repository**:
   - Navigate to 'Settings' > 'Repositories' > 'Connect Repo using HTTPS'.
   - Enter your repository's details.

## 5. Creating an Application in Argo CD
1. **Navigate to 'New App'**: Fill in details like application name, project, sync policy, and the repository URL.
   
2. **Select the Path**: Choose the path within your repository where the Kubernetes manifests are located.

3. **Deploy**: Click 'Create' to deploy your application.

## 6. Syncing the Application
- Argo CD automatically syncs the application according to the defined policy. You can manually sync it as well.

## 7. Verification
- Use `kubectl` to verify the deployment in your Kubernetes cluster.

