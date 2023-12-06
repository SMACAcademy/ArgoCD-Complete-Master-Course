
# Switch Between Contexts in ArgoCD

This guide demonstrates how to switch between different contexts in ArgoCD, useful for managing multiple ArgoCD server instances.

## Step 1: Understand ArgoCD Contexts

ArgoCD CLI uses contexts to manage multiple ArgoCD servers. Each context contains the server address, authentication token, and configuration details.

## Step 2: List Current Contexts

To view available ArgoCD contexts:

```bash
argocd context
```

This lists all contexts with the current context marked.

## Step 3: Set up Multiple ArgoCD Contexts

If you have multiple ArgoCD servers, set up a context for each.

1. **Login to Each ArgoCD Server**:
   Authenticate with each server:
   ```bash
   argocd login <argocd-server-address>
   ```

## Step 4: Switching Between Contexts

Switch between contexts as needed.

1. **Switch Context**:
   ```bash
   argocd context <context-name>
   ```

## Step 5: Verify the Current Context

After switching, verify the current context:

```bash
argocd context
```

### Additional Notes:

- ArgoCD contexts are different from Kubernetes contexts.
- Each context stores its own authentication token.

This guide is helpful for managing multiple ArgoCD installations across different Kubernetes clusters or environments.
