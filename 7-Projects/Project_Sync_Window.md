
# Argo CD Project Sync Window Demonstration

## Creating a Sync Window
Define a sync window in your Argo CD project to specify when synchronization can occur. For instance, to allow sync only during off-peak hours:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: myproject
spec:
  syncWindows:
    - kind: Allow
      schedule: "0 22 * * *"
      duration: "8h"
      applications: "*"
```

This configuration allows synchronization every day starting at 10 PM for a duration of 8 hours.

## Applying the Configuration
Apply this configuration to your project in Argo CD.

## Sync Window Enforcement
With this sync window in place, Argo CD will only synchronize applications within `myproject` during the specified timeframe. Any sync requests outside this window will be queued and executed once the window opens.
