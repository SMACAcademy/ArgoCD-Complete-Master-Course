
# Argo CD Self-Healing Feature Demonstration

## Prerequisites
- An operational Argo CD installation
- Access to a Kubernetes cluster with Argo CD installed
- A Git repository with Kubernetes manifests

## Steps

### 1. Deployment Manifest (`nginx-deployment.yaml`)

This is a simple Kubernetes deployment manifest for an Nginx server:

[0-Demo_Files/Nginx_Deployment/nginx-deployment.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment/nginx-deployment.yaml)

### 2. Argo CD Application Manifest (`argo-app.yaml`)

This defines the Argo CD application that points to the repository containing your Kubernetes manifests:

[0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app.yaml)

## Steps and Commands

1. **Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

2. **Install Argo CD in Your Cluster**:
   - [1-Installation_and_Setup/2-ArogCD_and_ArogCD_CLI_Installation.md](../1-Installation_and_Setup/2-ArogCD_and_ArogCD_CLI_Installation.md)

3. **Create Argo CD Application**:
   - Apply the Argo CD Application manifest:
     ```bash
     kubectl apply -f 0-Demo_Files/Nginx_Deployment_ArgoCD_Apps/argo-app.yaml
     ```

4. **Simulate a Manual Change in the Cluster**:
   - Change the number of replicas:
     ```bash
     kubectl scale deployment/nginx-deployment --replicas=1 -n argocdappdemo
     ```

5. **Observe Argo CD's Self-Healing Action**:
   - Argo CD will detect the deviation and revert the changes.

6. **Verify the Reversion**:
   - Check the number of replicas:
     ```bash
     kubectl get deployment/nginx-deployment -n argocdappdemo
     ```
   - The deployment should be back to 2 replicas.

## Monitoring through Argo CD UI

- Use Argo CD's web UI to monitor these changes.
