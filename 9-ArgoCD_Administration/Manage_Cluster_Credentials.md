
# Manage Cluster Credentials in ArgoCD

This guide provides steps to manage cluster credentials in ArgoCD, crucial for working with multi-cluster environments. It assumes ArgoCD is installed and basic operations are understood.

## Step 1: Access ArgoCD CLI

Ensure you have access to the ArgoCD command-line interface (CLI).

## Step 2: Add Cluster Credentials to ArgoCD

To add a new cluster, register its credentials with ArgoCD.

1. **Get the Cluster's Context**:
   List all contexts in your kubeconfig:
   ```bash
   kubectl config get-contexts
   ```

2. **Add Cluster to ArgoCD**:
   Use the ArgoCD CLI:
   ```bash
   argocd cluster add <context-name>
   ```

## Step 3: Verify the Cluster in ArgoCD

After adding the cluster, ensure it's correctly registered.

1. **List Registered Clusters**:
   ```bash
   argocd cluster list
   ```

2. **Check Specific Cluster Details**:
   ```bash
   argocd cluster get <cluster-name>
   ```

## Step 4: Manage Cluster Credentials

Update or remove cluster credentials as needed.

1. **Update Cluster Credentials**:
   ```bash
   argocd cluster add <context-name> --update
   ```

2. **Remove Cluster from ArgoCD**:
   ```bash
   argocd cluster rm <cluster-name>
   ```

## Step 5: Working with Cluster Roles and Bindings

Set up roles and role bindings for access control.

1. **Create Role and RoleBinding YAML** (`cluster-role.yaml`):
   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     name: argocd-role
     namespace: <your-namespace>
   rules:
   - apiGroups: [""]
     resources: ["pods", "services"]
     verbs: ["get", "list"]
   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: RoleBinding
   metadata:
     name: argocd-role-binding
     namespace: <your-namespace>
   subjects:
   - kind: ServiceAccount
     name: argocd
     namespace: argocd
   roleRef:
     kind: Role
     name: argocd-role
     apiGroup: rbac.authorization.k8s.io
   ```

2. **Apply the Role and RoleBinding**:
   ```bash
   kubectl apply -f cluster-role.yaml
   ```

This guide is essential for maintaining a secure and efficient multi-cluster environment in ArgoCD.
