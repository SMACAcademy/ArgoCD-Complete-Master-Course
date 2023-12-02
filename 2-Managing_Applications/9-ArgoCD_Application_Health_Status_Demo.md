### 1. Initial Setup
**a. Install ArgoCD**


- Ensure ArgoCD is installed in your Kubernetes cluster. Use the same installation steps as before if it's not already installed.

**b. Deploy an Application**

[0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app-history-rollback.yaml](../0-Demo-Files/Nginx-Deployment-Argo-Apps/argo-app-history-rollback.yaml)

- Apply with `kubectl apply -f argo-app-history-rollback.yaml`.

 ```bash
kubectl apply -f argo-app-history-rollback.yaml

argocd app get sample-app

```

- Apply this file with `kubectl apply -f application.yaml`.

### 2. Configure Health Checks
**a. Define Health Checks**


- In your application manifest (e.g., `deployment.yaml`), define liveness and readiness probes. Here's an example snippet:
- 
```yaml

livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
readinessProbe:
  httpGet:
    path: /ready
    port: 8080

```

**b. Apply the Changes**


- Update your application in the Git repository and sync the changes in ArgoCD.

### 3. View Health Status
**a. Check Application Status in ArgoCD**


- Use the ArgoCD CLI or UI to check the health status of your application.
- CLI command:

```bash

argocd app get sample-app

```

### 4. Status Reporting
**a. Inspect Application Resources**


- To get detailed status reports of all resources in the application, use:
 
```bash

argocd app resources sample-app

```

**b. View in UI**


- In the ArgoCD UI, navigate to the application details to see a graphical representation of the health and status of each resource.

### 5. Test Health Checks
**a. Simulate Failure**


- Temporarily modify the health check endpoint in your application to simulate a failure.
- For example, change the path in the liveness or readiness probe to an invalid endpoint.

**b. Observe the Response**


- Sync the application in ArgoCD and observe how it reports the unhealthy status.

### 6. Rollback to Healthy State
**a. Revert Changes**


- Revert the changes in your Git repository to the last known good configuration.

**b. Sync and Verify**


- Sync the application in ArgoCD and verify that it returns to a healthy state.


### Clean Up (Optional)
Delete the application if it was just for demonstration: kubectl delete -f app.yaml -n argocd.


### Notes

- Customize the `application.yaml` and health check configurations according to your specific application requirements.
- Make sure to update the repository URLs and paths as per your setup.

This guide provides a basic outline for demonstrating the Health Checks and Status Reporting features in ArgoCD. Depending on your specific environment and application, some steps may need adjustment.

