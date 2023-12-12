
# ArgoCD Synchronization Options

ArgoCD is a popular tool for implementing GitOps practices in Kubernetes environments. Here's a breakdown of the different synchronization options you might encounter in ArgoCD, particularly Prune, Dry run, Apply only, and Force:

## 1. Prune
When you synchronize with the prune option enabled, ArgoCD not only applies the changes that are defined in the repository, but it also removes any resources that are no longer defined in the repository but still exist in the cluster. This is useful for ensuring that the cluster state exactly matches the state defined in the Git repository. If a resource was removed from the repository, it will also be removed from the cluster.

## 2. Dry Run
The dry run option is a way to preview what changes ArgoCD would make to your Kubernetes cluster without actually applying them. This is a kind of "simulation" mode where you can see the outcome of a synchronization without affecting the actual cluster state. It's useful for verifying changes or for debugging.

## 3. Apply Only
This mode instructs ArgoCD to apply changes that are present in the Git repository to the Kubernetes cluster but not to remove anything. Unlike prune, it doesn't delete resources that are no longer present in the repository. This can be useful when you want to ensure that new changes are rolled out, but you don't want to accidentally delete resources that might have been removed from the Git repository.

## 4. Force
The force synchronization option is a more aggressive form of apply. It's used when you want to ensure that the cluster state is forcefully aligned with the state defined in the Git repository. This might be necessary when you have some kind of drift in the cluster state that isn't being corrected by normal synchronization processes. Force synchronization can potentially disrupt services, so it's used cautiously.

Each of these options serves a different purpose in managing the state of your Kubernetes cluster in accordance with the declarative configurations stored in your Git repository. The choice between them depends on your specific needs for deploying and maintaining applications in a Kubernetes environment.




# Argo CD Synchronization Options Demonstration

This guide provides sample files and commands to demonstrate different Argo CD synchronization options like `prune`, `dry run`, `apply only`, and `force`.

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune option.

- [0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app-prune-demo.yaml
```


### 3. Argo CD Commands and Options

1. **Dry Run**:
   - Command: `argocd app sync prunetestapp --dry-run`
   - Observe changes without applying them.

2. **Apply Only (Without Prune)**:
   - Command: `argocd app sync prunetestapp`
   - Applies changes but doesn't delete anything removed from the repository.

3. **Prune**:
   - Command: `argocd app sync prunetestapp --prune`
   - Deletes resources in the cluster that are no longer in the repository.

4. **Force**:
   - Command: `argocd app sync prunetestapp --force`
   - Reapplies all resources in the repository to the cluster.

### 5. Visualization and Understanding

- Monitor the application status using Argo CD UI or CLI.
- Use `kubectl get all` to observe changes in your Kubernetes cluster.
- Each command's effect will help understand how Argo CD synchronization options work.

## Note

- Replace `APP_NAME` with the actual name of your Argo CD application.
- Ensure your Kubernetes cluster and Argo CD are set up to track the repository containing these files.
