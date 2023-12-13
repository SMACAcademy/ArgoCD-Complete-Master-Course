
# Demonstration of "Respect Ignore Differences" in ArgoCD Sync

This guide outlines how to demonstrate the "Respect Ignore Differences" feature in ArgoCD Sync. This feature is crucial for cases where ArgoCD should ignore specific changes in the Kubernetes cluster that are not crucial to the application's operation.

## Pre-requisites
1. **ArgoCD Installed**: ArgoCD should be installed and operational in your Kubernetes cluster.
2. **Access to ArgoCD**: Ensure you have access to the ArgoCD UI or CLI.
3. **Sample Application**: An application in ArgoCD for the demonstration.

## Steps for Demonstration

### Git setups
**Clone files from Git Repository**:
   - [2-Managing_Applications/0-Cloning_Git_Repo.md](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/2-Managing_Applications/0-Cloning_Git_Repo.md)

## Steps

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune optison.

- [0-Demo_Files/Ignore_Diff_Apps/argo-app-sync-Ignorediff.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Ignore_Diff_Apps/argo-app-sync-Ignorediff.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Ignore_Diff_Apps/argo-app-sync-Ignorediff.yaml
```


### 3. Modify the ConfigMap in the Cluster
Simulate a cluster-side change:

**Kubectl Command:**
```bash
kubectl patch configmap demo-configmap -p '{"data":{"key1":"new-value"}}' -n argocdappdemo-ignorediff
```

### 4. Observe Out-of-Sync Status in ArgoCD
ArgoCD will detect a drift due to the change.

### 5. Update ArgoCD Application to Ignore Differences
Set up ArgoCD to ignore certain differences.

**Application YAML (ArgoCD):**
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: demo-application
spec:
  # ... other fields ...
  ignoreDifferences:
    - kind: ConfigMap
      name: demo-configmap
      jsonPointers:
        - /data/key1
```

Apply this to your ArgoCD application.

### 6. Sync the Application and Observe
- Sync in ArgoCD.
- ArgoCD should now show the application as in-sync, despite the differences.

### 7. Verify and Discuss Results
- Verify that ArgoCD ignores the specified differences.
- Discuss use cases and implications of this feature.

## Conclusion
This demonstration showcases the utility of the "Respect Ignore Differences" feature in ArgoCD, especially for dynamic fields in resources. It emphasizes the importance of careful usage to avoid overlooking significant discrepancies in deployments.
