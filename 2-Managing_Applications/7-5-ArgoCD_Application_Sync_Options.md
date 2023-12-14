
# Argo CD Synchronization Options Demonstration

This guide provides sample files and commands to demonstrate various Argo CD synchronization options like `skip schema validation`, `prune last`, `respect ignore differences`, `apply out of sync only`, and `serverside apply`.

## Prerequisites
- An operational Argo CD installation
- Access to a Kubernetes cluster with Argo CD installed
- A Git repository with Kubernetes manifests

## Git setup
**Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

## Steps

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune optison.

For other demo
- [0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml)

For Schema validation demo
- [0-Demo_Files/With_Schema_Error_Apps/argo-app-sync-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/With_Schema_Error_Apps/argo-app-sync-demo.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/With_Schema_Error/sync-options-demo.yaml --dry-run=server

kubectl apply -f 0-Demo_Files/With_Schema_Error_Apps/argo-app-sync-demo.yaml
```

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml
```


## Argo CD Commands for Different Options


1. **Skip Schema Validation**:
   - Command: `argocd app set syncoptionsdemo --sync-option Validate=false`

2. **Prune Last**:
   - Command: `argocd app set syncoptionsdemo --sync-option PruneLast=true`

3. **Respect Ignore Differences**:
   - Command: `argocd app set syncoptionsdemo --sync-option RespectIgnoreDifferences=true`

4. **Apply Out of Sync Only**:
   - Command: `argocd app set syncoptionsdemo --sync-option ApplyOutOfSyncOnly=true`

5. **Serverside Apply**:
   - Command: `argocd app set syncoptionsdemo --sync-option ServerSideApply=true`
   
6. **Create Namespace**:
   - Command: `argocd app set syncoptionsdemo --sync-option CreateNamespace=true`  


## Argo CD CLI Command to sync the application after setting the above options
   - Sync Application using `argocd app sync syncoptionsdemo`

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



## Visualization and Understanding

- Monitor the application in Argo CD after running each command.
- Use `kubectl get all -n argocdappdemo` commands to see the state of Kubernetes resources.
- Compare the states to understand the impact of each synchronization option.

## Note

- Ensure your Kubernetes cluster and Argo CD are set up to track the repository containing these files.
