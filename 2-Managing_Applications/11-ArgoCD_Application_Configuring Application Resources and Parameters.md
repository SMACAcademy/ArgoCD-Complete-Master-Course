
# Demonstrating Application Parameters in Argo CD

This guide provides an overview of application parameters in Argo CD, such as `directory recurse`, `top-level arguments`, `external variables`, `include`, and `exclude`, along with sample files and commands.

## Sample Application Structure

Consider a Git repository with this structure:

```
.
├── apps
│   ├── app1
│   │   └── deployment.yaml
│   └── app2
│       └── deployment.yaml
└── libs
    └── common.yaml
```

## Steps

### 1. Define a Kubernetes Application
Create an `Application` resource in Argo CD. This YAML file defines the application, its source repository, and the sync policy, including the prune option.

- [0-Demo_Files/Params_Demo_Apps/argo-app-param-demo.yaml](https://github.com/SMACAcademy/ArgoCD-Complete-Master-Course/blob/main/0-Demo_Files/Params_Demo_Apps/argo-app-param-demo.yaml)

### 2. Apply the Application
Deploy this application to your Argo CD environment using `kubectl`.

**Command:**
```bash
kubectl apply -f 0-Demo_Files/Params_Demo_Apps/argo-app-param-demo.yaml
```



## 1. Directory Recurse

- **Purpose**: Recursively look into directories for Kubernetes manifests.
- **Usage**: Use for multiple applications in subdirectories (`apps/app1`, `apps/app2`).
- **Command**: Set in Argo CD application manifest.

## 2. Top-Level Arguments

- **Purpose**: Pass arguments to tools like Helm or Kustomize.
- **Usage**: Pass values files or set specific values for Helm deployments.
- **Command**: `argocd app set APP_NAME --helm-set key=value`
- **Example**: `argocd app set my-app --helm-set image.tag=v1.2.3`

## 3. External Variables

- **Purpose**: Pass dynamic data into Argo CD applications.
- **Usage**: Customize deployments using environment variables.
- **Command**: Set in CI/CD pipeline script.
- **Example**: `export IMAGE_TAG=v1.2.3`

## 4. Include and Exclude

- **Purpose**: Include or exclude certain resources or directories.
- **Usage**: Exclude directories like `libs` from being considered.
- **Exclude Example**:
  ```yaml
  source:
    repoURL: 'https://your-repo-url.git'
    path: '.'
    directory:
      recurse: true
      exclude: 'libs/*'
  ```
- **Include Example**:
  ```yaml
  source:
    repoURL: 'https://your-repo-url.git'
    path: 'apps/app1/*'
  ```

## Visualization and Understanding

- Observe the Argo CD UI or CLI to see how these parameters affect resource synchronization and application.
- Changes will reflect in the way Argo CD deploys and manages resources based on your configuration.

## Note

- Replace `APP_NAME` with your Argo CD application name.
- Ensure your repository structure aligns with the Argo CD configuration.
