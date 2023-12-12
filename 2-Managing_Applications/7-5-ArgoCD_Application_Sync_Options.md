
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




## Argo CD Prune Options: Purpose, Function, and Use Cases

This document explains the purpose, functionality, and typical use cases for various Argo CD prune options.

1. **Skip Schema Validation**:
   - **Purpose**: Bypasses Kubernetes schema validation when syncing resources.
   - **How it Functions**: Does not validate resource manifests against the Kubernetes OpenAPI schema before applying them.
   - **Use Cases**: Useful for deploying valid resources that might be blocked by schema validation, especially with CRDs or extended Kubernetes APIs.

2. **Prune Last**:
   - **Purpose**: Ensures resource deletion (pruning) is performed after applying all other resources.
   - **How it Functions**: Applies new or updated resources first, then prunes resources that are no longer defined in the Git repository.
   - **Use Cases**: Ideal for minimizing downtime and managing dependencies, ensuring new resources are operational before removing old ones.

3. **Respect Ignore Differences**:
   - **Purpose**: Tells Argo CD to respect the 'ignoreDifferences' field in resource tracking.
   - **How it Functions**: Ignores certain specified differences between live and desired states during sync.
   - **Use Cases**: Useful for ignoring modifications made by the Kubernetes system or other operators that should not trigger a sync.

4. **Apply Out of Sync Only**:
   - **Purpose**: Limits the sync process to resources detected as out of sync.
   - **How it Functions**: Compares the current state of resources with their desired state in Git, applying changes only to those that differ.
   - **Use Cases**: Beneficial in large clusters or applications where it's inefficient to apply every resource during every sync.

5. **Server-Side Apply**:
   - **Purpose**: Utilizes Kubernetes' server-side apply feature for the sync process.
   - **How it Functions**: The Kubernetes API server performs the merge operation of the resource state.
   - **Use Cases**: Useful in environments with complex deployments, improving conflict detection and resolution.

These options provide advanced control over the sync process in Argo CD, allowing for more tailored and efficient management of Kubernetes resources.

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
