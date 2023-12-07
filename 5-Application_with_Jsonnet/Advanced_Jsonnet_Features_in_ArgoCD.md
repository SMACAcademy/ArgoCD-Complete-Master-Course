
# Advanced Jsonnet Features in ArgoCD

## Step 1: Importing Files in Jsonnet

Jsonnet allows the import of other Jsonnet files for modular configurations.

### Sample Jsonnet Files

- **config.jsonnet**
  ```jsonnet
  {
    repoURL: 'https://github.com/your/repo.git',
    branch: 'master'
  }
  ```

- **app.jsonnet**
  ```jsonnet
  local config = import 'config.jsonnet';

  {
    apiVersion: 'argoproj.io/v1alpha1',
    kind: 'Application',
    metadata: {
      name: 'my-app',
      namespace: 'argocd',
    },
    spec: {
      project: 'default',
      source: {
        repoURL: config.repoURL,
        targetRevision: config.branch,
        path: 'path/to/app',
      },
      destination: {
        server: 'https://kubernetes.default.svc',
        namespace: 'default',
      },
    },
  }
  ```

## Step 2: Using Functions in Jsonnet

Functions in Jsonnet allow the creation of parametrized components.

### Sample Function in Jsonnet

- **app-function.jsonnet**
  ```jsonnet
  local app(name, path, namespace) = {
    apiVersion: 'argoproj.io/v1alpha1',
    kind: 'Application',
    metadata: { name: name, namespace: 'argocd' },
    spec: {
      project: 'default',
      source: { repoURL: 'https://github.com/your/repo.git', targetRevision: 'HEAD', path: path },
      destination: { server: 'https://kubernetes.default.svc', namespace: namespace },
    },
  };

  {
    app1: app('app1', 'path/to/app1', 'dev'),
    app2: app('app2', 'path/to/app2', 'prod')
  }
  ```

## Step 3: Leveraging External Variables

External variables in Jsonnet can be passed from the command line or other external sources.

### Sample External Variable Usage

- **Command to Compile Jsonnet File**
  ```bash
  jsonnet --ext-str name=app1 --ext-str namespace=dev app.jsonnet
  ```

## Step 4: Combining Features

These advanced features can be combined to create complex, reusable, and customizable ArgoCD configurations using Jsonnet.

