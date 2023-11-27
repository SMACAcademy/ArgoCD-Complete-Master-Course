
# Managing Application Lifecycle in ArgoCD

## Initial Setup
- Install ArgoCD in your Kubernetes cluster.
- Set up your Git repository with the desired application manifests.

## Creating an Application
- Create an application using the ArgoCD CLI or by applying an Application manifest using `kubectl`.

## Syncing an Application
- Perform an initial sync using `argocd app sync` or via the ArgoCD UI.

## Updating an Application
- Push updates to the Git repository containing the application manifests.
- Sync changes with `argocd app sync` or let ArgoCD auto-sync if configured.

## Rolling Back an Application
- Rollback to a previous state with `argocd app rollback` if necessary.

## Monitoring Application Health
- Monitor the application's health and status with `argocd app get`.

## Cleaning Up
- Remove the application with `argocd app delete` when it is no longer needed.
