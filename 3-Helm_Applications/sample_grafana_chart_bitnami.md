

# Install Bitnami Grafana Helm Chart in Argo CD

## Install Grafana through Argo CD UI

### 1. Open Argo CD UI
Access the Argo CD web interface.

### 2. Add Application
Click on 'New App' (usually found at the top right corner).

### 3. Fill in Application Details
- **Application Name**: Enter `grafana`.
- **Project**: Select `default`.
- **Source Repository URL**: Enter `https://charts.bitnami.com/bitnami`.
- **Chart**: Type `grafana`.
- **Target Revision**: Set to `HEAD` or specify a version.
- **Destination**: Choose the cluster and namespace where you want Grafana to be deployed.
- **Sync Policy**: Optionally, set to 'Automatic'.

### 4. Create
Click on the 'Create' button to create the application.

## Access and Login to Grafana

### 1. Port Forwarding
After Grafana is deployed, use kubectl to port forward:
```bash
kubectl port-forward svc/grafana 8080:80 -n [your-namespace]
```
Replace `[your-namespace]` with the namespace you deployed Grafana to.

### 2. Get Grafana Password
```bash
kubectl get secret --namespace [your-namespace] grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```
Replace `[your-namespace]` with the namespace you deployed Grafana to.

### 3. Access Grafana
Open your web browser and go to `http://localhost:8080`. 

### 4. Login
Use `admin` as the username and the password obtained from the previous step.

By following these steps, you'll successfully install the Bitnami Grafana Helm chart as an Argo CD application through the UI and access the Grafana dashboard.


