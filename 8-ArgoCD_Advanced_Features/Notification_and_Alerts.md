
# Argo CD Notifications and Alerts Demonstration

## Step 1: Install Argo CD Notifications
Install the Argo CD Notifications controller in your Kubernetes cluster:

```bash
kubectl create namespace argocd-notifications
kubectl apply -n argocd-notifications -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/stable/manifests/install.yaml
```

## Step 2: Configure Notification Triggers and Templates
Edit the `argocd-notifications-cm` ConfigMap to define notification triggers and templates.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
  namespace: argocd-notifications
data:
  template.app-out-of-sync: |
    title: Application {{.app.metadata.name}} is out of sync
    body: |
      Application {{.app.metadata.name}} is out of sync!
  trigger.on-sync-status-changed: |
    - when: app.status.sync.status == 'OutOfSync'
      send: [app-out-of-sync]
      oncePer: 2m
```

## Step 3: Configure Notification Services
For example, configure Slack in `argocd-notifications-secret`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: argocd-notifications-secret
  namespace: argocd-notifications
stringData:
  slack-token: <your-slack-token>
```

## Step 4: Subscribe Applications to Notifications
Annotate Argo CD Applications to receive notifications.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: example-application
  annotations:
    notifications.argoproj.io/subscribe.on-sync-status-changed.slack: my-slack-channel
```

## Step 5: Test Notifications
1. **Trigger a Condition**: Make a change in the Git repository to cause the application to be out of sync.
2. **Check Notification Channel**: Verify the notification in the configured service (e.g., Slack).
3. **Review Logs**: Check the logs of the Argo CD Notifications controller.

## Additional Tips
- Ensure compatibility with your Argo CD version.
- Manage tokens and secrets securely.
- Customize notifications for different events and channels as needed.
