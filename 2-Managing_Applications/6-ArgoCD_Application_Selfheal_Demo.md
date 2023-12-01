
# Argo CD Self-Healing Feature Demonstration

## Sample Files

### 1. Deployment Manifest (`nginx-deployment.yaml`)

This is a simple Kubernetes deployment manifest for an Nginx server:

[0-Demo-Files/Nginx-Deployment/nginx-deployment.yaml](../0-Demo-Files/Nginx-Deployment/nginx-deployment.yaml)

### 2. Argo CD Application Manifest (`argo-app.yaml`)

This defines the Argo CD application that points to the repository containing your Kubernetes manifests:

[0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app.yaml](../0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app.yaml)

## Steps and Commands

1. **Commit and Push Your Files to Git Repository**:
   - Place these files in your Git repository and push them.

2. **Install Argo CD in Your Cluster**:
   - [1-Installation_and_Setup/2-ArogCD_and_ArogCD_CLI_Installation.md](../1-Installation_and_Setup/2-ArogCD_and_ArogCD_CLI_Installation.md)

3. **Create Argo CD Application**:
   - Apply the Argo CD Application manifest:
     ```bash
     kubectl apply -f argo-app.yaml -n argocd
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
