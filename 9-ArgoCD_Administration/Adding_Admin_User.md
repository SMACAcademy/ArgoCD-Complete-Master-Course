
# Adding a New User to ArgoCD

## Instructions

### 1. Edit ArgoCD ConfigMap for User Credentials
- Open the terminal and run the following command to edit the ArgoCD ConfigMap:
  ```bash
  kubectl edit configmap argocd-cm -n argocd
  ```
- In the editor that opens, navigate to the `data` section.
- Add the new user credentials under this section in the following format:
  ```
  data:
    accounts.kumar: apiKey,login
  ```
- Save and exit the editor. This step adds the user `kumar` with the ability to use `apiKey` and `login`.

### 2. Edit ArgoCD RBAC ConfigMap for User Roles
- Run the following command to edit the RBAC ConfigMap:
  ```bash
  kubectl edit configmap argocd-rbac-cm -n argocd
  ```
- Under the `data` section, update the `policy.csv` with the user role. Add the following lines:
  ```
  data:
    policy.csv: |
      g, kumar, role:admin
    scopes: '[groups]'
  ```
- This assigns the `admin` role to the user `kumar`.
- Save and exit the editor.

### 3. Update the User Password
- After adding the user and assigning the role, set or update the password for the new user `kumar` by executing:
  ```bash
  argocd account update-password --account kumar
  ```
- Follow the prompts to set a new password for `kumar`.

### 4. Verify the Setup
- Once the above steps are completed, verify that the user `kumar` has been added successfully and has the correct permissions.

### 5. Additional Notes
- Ensure that you have the necessary permissions to make these changes in your Kubernetes cluster.
- It's important to follow the best practices for managing users and roles in ArgoCD, especially in a production environment.
