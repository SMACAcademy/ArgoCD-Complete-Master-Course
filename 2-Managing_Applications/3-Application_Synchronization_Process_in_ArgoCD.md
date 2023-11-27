
# Application Synchronization Process in ArgoCD

The synchronization process in ArgoCD is a critical operation that ensures the desired state in the Git repository is applied to the target Kubernetes cluster. ArgoCD provides a variety of sync options to tailor this process to the needs of your applications.

## Sync Options Overview

ArgoCD allows users to customize the synchronization process through specific sync options that can be defined in the Application resource or as annotations on individual resources.

### Examples of Sync Options

Here are some of the sync options you can configure:

#### No Prune Resources

Prevent specific objects from being pruned by setting:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-options: Prune=false
```

#### Disable Kubectl Validation

For resources that require `kubectl apply` with `--validate=false`:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-options: Validate=false
```

#### Skip Dry Run for New Custom Resources

If the CRD is not part of the sync:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
```

#### Selective Sync

To sync only out-of-sync resources:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - ApplyOutOfSyncOnly=true
```

#### Prune Deletion Propagation Policy

Control the pruning policy:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - PrunePropagationPolicy=foreground
```

#### Prune Last

To prune resources after all other resources are healthy:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - PruneLast=true
```

#### Replace Resource Instead of Applying Changes

Use `kubectl replace` or `kubectl create`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - Replace=true
```

#### Server-Side Apply

For larger resources or more declarative approach:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - ServerSideApply=true
```

#### Fail the Sync on Shared Resources

Avoid conflicts with other Applications:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  syncPolicy:
    syncOptions:
    - FailOnSharedResource=true
```

#### Respect Ignore Differences Configs

Consider `ignoreDifferences` during sync:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
spec:
  ignoreDifferences:
  - group: "apps"
    kind: "Deployment"
    jsonPointers:
    - /spec/replicas
  syncPolicy:
    syncOptions:
    - RespectIgnoreDifferences=true
```

#### Create Namespace

Automatically create the specified namespace:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
    namespace: some-namespace
  syncPolicy:
    syncOptions:
    - CreateNamespace=true
```

To apply these sync options, include them in your Application YAML and use `kubectl apply -f your-application.yaml` to create or update your ArgoCD application. Monitor the synchronization through the ArgoCD UI or CLI.
