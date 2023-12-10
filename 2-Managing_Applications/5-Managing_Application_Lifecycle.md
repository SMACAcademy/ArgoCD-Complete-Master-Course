
# Managing Application Lifecycle in ArgoCD

## Initial Setup
- Install ArgoCD in your Kubernetes cluster.
- Set up your Git repository with the desired application manifests.


## Creating an Application
- Create an application using the ArgoCD CLI or by applying an Application manifest using `kubectl`.


### Defining Applications with YAML

Create a YAML file that defines your ArgoCD application. Here's an example YAML with explanations:

[0-Demo_Files/Sample_Deployment_Service_ArgoCD_Apps/application.yaml] (https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Sample_Deployment_Service_ArgoCD_Apps/application.yaml)


### Applying the YAML File

Once the YAML file is ready, apply it to your cluster with the following command:

```bash
kubectl apply -f 0-Demo_Files/Sample_Deployment_Service_ArgoCD_Apps/application.yaml
```

## login to ArgoCD CLI
- Login to ArgoCD CLI by following the instruction at https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/1-Installation_and_Setup/2-ArogCD_and_ArogCD_CLI_Installation.md 

## Syncing an Application
- Perform an initial sync using `argocd app sync argo-sample-deployment-service` or via the ArgoCD UI.

## Updating an Application
- Push updates to the Git repository containing the application manifests.
- Sync changes with `argocd app sync argo-sample-deployment-service` or let ArgoCD auto-sync if configured.

## Monitoring Application Health
- Monitor the application's health and status with `argocd app get argo-sample-deployment-service`.

## Cleaning Up
- Remove the application with `argocd app delete argo-sample-deployment-service` when it is no longer needed.

# Optional Steps

## View history of an Application
- View history of the app using `argocd app history history-rollback-demo`.

## Rolling Back an Application
- Rollback to a previous state with `argocd app rollback` if necessary.