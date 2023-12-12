
# ArgoCD Synchronization Options

ArgoCD is a popular tool for implementing GitOps practices in Kubernetes environments. Here's a breakdown of the different synchronization options you might encounter in ArgoCD, particularly Prune, Dry run, Apply only, and Force:

## 1. Prune
- The "prune" option in Argo CD is used when you want to ensure that the Kubernetes cluster's state exactly matches the state defined in your Git repository.
- If there are resources in the Kubernetes cluster that are no longer defined in the Git repository, the "prune" option will delete these resources. This ensures that all and only the resources defined in your repository are present in the cluster.
- Pruning is critical for maintaining a clean and predictable cluster state, as it removes any resources that are no longer needed or that have been inadvertently left behind.

## 2. Dry Run
- The Dry Run option in Argo CD is a safe way to preview what changes would occur in your Kubernetes cluster without actually applying them.
- When you execute a Dry Run, Argo CD processes the manifests and computes the differences between the desired state (as defined in your Git repository) and the current state of the cluster. However, it does not make any actual changes to the cluster.
- This option is particularly useful for validation purposes. It lets you see what will happen if you were to synchronize, helping you to catch potential issues or unintended changes before they are applied to the cluster.

## 3. Apply Only
- The "apply only" option, on the other hand, focuses solely on applying the changes found in the Git repository to the cluster. It does not remove any existing resources, even if they are not present in the repository.
- This option is useful when you want to update or add resources as defined in Git, but do not want to remove anything that is already running in the cluster. It's a more conservative approach, ensuring that existing configurations or resources that are not managed through the current Git repository are not disturbed.

## 4. Force
- The Force option, on the other hand, is used to override certain checks and constraints during the synchronization process.
- When you use Force, Argo CD will apply changes to the cluster even if there are discrepancies that would normally block the synchronization. This includes situations like out-of-sync status, differences in resource state that can't be automatically reconciled, or when manual intervention is otherwise required.
- The Force option is useful in scenarios where you need to resolve a problematic state or you're confident about the changes and want to apply them despite warnings or conflicts.

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
