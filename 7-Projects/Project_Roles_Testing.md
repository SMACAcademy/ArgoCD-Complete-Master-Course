
# Testing Argo CD Project Roles

## Step 1: Define a Role in an Argo CD Project
Define a role within an Argo CD project. Example role `test-role` within a project named `example-project`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: example-project
  namespace: argocd
spec:
  roles:
    - name: test-role
      policies:
        - p, proj:example-project:test-role, applications, get, example-project/*, allow
        - p, proj:example-project:test-role, applications, sync, example-project/*, deny
      description: 'Role that can view but not sync applications'
```

## Step 2: Apply the Role to the Project
Apply the project configuration:

```bash
kubectl apply -f project_role.yaml
```

## Step 3: Assign the Role to a User
Update the `argocd-rbac-cm` ConfigMap with user-to-role mapping:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-rbac-cm
  namespace: argocd
data:
  policy.csv: |
    g, test-user, role:proj:example-project:test-role
```

Apply the ConfigMap:

```bash
kubectl apply -f rbac_config.yaml
```

## Step 4: Test the Role
1. **Login as the Assigned User**: Log in to the Argo CD UI or CLI as `test-user`.

2. **Attempt Allowed Actions**: Try to view applications in `example-project`. This should be allowed.

3. **Attempt Restricted Actions**: Try to sync any application in `example-project`. This should be denied.

## Step 5: Verify the Role Enforcement
1. **Check User Actions**: Verify in the Argo CD UI that `test-user` can see but not sync applications in `example-project`.

2. **Review Argo CD Logs**: Check the Argo CD logs for access denied entries corresponding to `test-user` actions.

3. **Assess Policy Effectiveness**: Ensure that the policies are correctly implemented and effective.

By following these steps, you can test and confirm the roles in your Argo CD project.
