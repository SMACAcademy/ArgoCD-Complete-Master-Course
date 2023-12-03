
# Repository Webhooks and Notifications in Argo CD

This guide demonstrates setting up repository webhooks and notifications in Argo CD, including sample files, commands, and details.

## 1. Understanding Webhooks and Notifications
- **Webhooks**: Automate synchronization of applications when changes are pushed to a Git repository.
- **Notifications**: Alert on events like sync status changes, application health status changes.

## 2. Prerequisites
- Argo CD installed in your Kubernetes cluster.
- A Git repository with Kubernetes manifests.

## 3. Setting Up Webhooks

### A. Creating a Webhook in the Git Repository
1. Go to your repository settings and navigate to the webhooks section.
2. Add a new webhook with the payload URL as `http://<argocd-server-service>.<namespace>.svc.cluster.local:8080/api/webhook`.

### B. Configuring Argo CD for Webhooks
Argo CD automatically reacts to incoming webhooks by default.

## 4. Setting Up Notifications

### A. Installing Argo CD Notifications
Install Argo CD Notifications in your Kubernetes cluster.

```bash
kubectl create namespace argocd-notifications
kubectl apply -n argocd-notifications -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/stable/manifests/install.yaml
```

### B. Configuring Notification Triggers and Templates
Define triggers and templates in the `argocd-notifications-cm` ConfigMap.

Example trigger and template:
```yaml
triggers:
  - name: on-sync-status-changed
    condition: app.status.sync.status == 'Synced'
    template: app-sync-status

templates:
  - name: app-sync-status
    title: Application {{.app.metadata.name}} sync status changed
    body: The sync status of application {{.app.metadata.name}} is now '{{.app.status.sync.status}}'.
```

### C. Configuring Notification Services
Add service credentials in the `argocd-notifications-secret` Secret.

Example for Slack:
```yaml
service.slack: |
  webhook: https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
```

## 5. Subscribing Applications to Notifications
Use annotations in Argo CD applications to subscribe to notifications.

```yaml
metadata:
  annotations:
    notifications.argoproj.io/subscribe.on-sync-status-changed.slack: my-channel
```

## 6. Verifying Setup
Test webhooks by pushing changes to your Git repository and checking Argo CD. Test notifications by triggering events.

## Conclusion
Setting up webhooks and notifications enhances automation and monitoring in Argo CD deployments. Refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/) and [Argo CD Notifications documentation](https://argoproj-labs.github.io/argocd-notifications/) for more details.
