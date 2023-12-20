
# Argo CD Project Sync Window Demonstration

## Creating a Sync Window
Define a sync window in your Argo CD project to specify when synchronization can occur. For instance, to allow sync only during off-peak hours:

### 1. Deployment Manifest (`sync-window.yaml`)

This is a simple Kubernetes deployment manifest for an argocd project:

[0-Demo_Files/Project_Intro/sync-window.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Project_Intro/sync-window.yaml)

This configuration allows synchronization every day starting at 10 PM for a duration of 8 hours.

## Applying the Configuration
Apply this configuration to your project in Argo CD.

## Sync Window Enforcement
With this sync window in place, Argo CD will only synchronize applications within `myproject` during the specified timeframe. Any sync requests outside this window will be queued and executed once the window opens.

```bash
kubectl apply -f 0-Demo_Files/Project_Intro/sync-window.yaml -n argocd

```
