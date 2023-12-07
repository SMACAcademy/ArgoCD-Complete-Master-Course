
# Testing and Validating Jsonnet Templates in ArgoCD

## Step 1: Writing Basic Jsonnet Template

Create a basic Jsonnet template for an ArgoCD application.

### Sample Jsonnet Template: `app.jsonnet`
```jsonnet
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
      repoURL: 'https://github.com/your/repo.git',
      targetRevision: 'HEAD',
      path: 'path/to/app',
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: 'default',
    },
  },
}
```

## Step 2: Writing Tests for Jsonnet Templates

Write tests for your Jsonnet templates to ensure correct rendering.

### Sample Test File: `app_test.jsonnet`
```jsonnet
local app = import 'app.jsonnet';

{
  testAppKind: app.kind == 'Application',
  testMetadata: app.metadata.name == 'my-app',
}
```

## Step 3: Running Jsonnet Tests

Run tests using a Jsonnet testing framework like `jsonnetunit`.

### Commands to Install and Run Tests
```bash
# Installing jsonnetunit (assuming you have Go installed)
go get github.com/yugui/jsonnetunit

# Running tests
jsonnetunit app_test.jsonnet
```

## Step 4: Validating Jsonnet Templates

Validate Jsonnet templates to ensure they produce valid Kubernetes manifests.

### Commands to Validate Jsonnet Output
```bash
# Install kubeval
brew install kubeval

# Render Jsonnet and validate with kubeval
jsonnet app.jsonnet | kubeval
```

## Step 5: Continuous Integration

Integrate testing and validation into your CI/CD pipeline for automated checks.

