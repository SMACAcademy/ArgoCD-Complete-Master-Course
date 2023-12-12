
# Demonstrating Propagation Policy in Argo CD

To demonstrate and visualize the `Propagation Policy` in Argo CD, follow these steps with sample files in a Kubernetes environment.

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

- [0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml
```

## Steps to Visualize Propagation Policy

1. **Deploy the Application using Argo CD**:
   - Connect your Git repository to Argo CD.
   - Create an Argo CD application pointing to this repository.

2. **Observe the Initial Deployment**:
   - Ensure the application is successfully deployed in your Kubernetes cluster.

3. **Modify the Application Configuration for Pruning**:
   - Remove the Service definition from the YAML file and push the changes to your Git repository.

4. **Apply Different Propagation Policies**:


    More Info : https://kubernetes.io/docs/concepts/architecture/garbage-collection/#controlling-how-the-garbage-collector-deletes-dependents

    ### 1. Background Propagation Policy
    To use the Background propagation policy, run the following command:

    ```bash
    argocd app set prunetestapp --sync-option PrunePropagationPolicy=background
    ```
    This policy allows Argo CD to perform the sync operation in the background, continuously applying and re-applying manifests to achieve the desired state.

    ### 2. Foreground Propagation Policy
    For the Foreground propagation policy, use this command:

    ```bash
    argocd app set prunetestapp --sync-option PrunePropagationPolicy=foreground
    ```
    With Foreground policy, Argo CD deletes resources in the foreground, waiting for the Kubernetes garbage collector to delete all dependent resources before deleting the owner resources.

    ### 3. Orphan Propagation Policy
    To use the Orphan propagation policy, which prevents automatic pruning of resources that are no longer tracked in the Git repository, use the following command:

    ```bash
    argocd app set prunetestapp --sync-option PrunePropagationPolicy=orphan
    ```

    

5. **Visualization**:
   - Use `kubectl get` commands to observe resource states in your cluster.
   - Optionally, use the Kubernetes dashboard or Argo CD UI for visual observation.

Follow these steps to understand how each propagation policy affects resource management in Argo CD.
