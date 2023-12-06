
# Multi-cluster Application Management in ArgoCD

This guide demonstrates setting up multi-cluster application management in ArgoCD. It assumes that ArgoCD is installed and you have access to multiple Kubernetes clusters. The focus is on registering clusters in ArgoCD, creating a project, and managing applications across these clusters.

## Step 1: Set Up Clusters in ArgoCD

### Register Your Kubernetes Clusters in ArgoCD

1. **Get the Cluster's Context Name**:
   Retrieve the context name of your Kubernetes cluster using:
   ```bash
   kubectl config get-contexts
   ```

2. **Add Cluster to ArgoCD**:
   Add each cluster to ArgoCD using its context name:
   ```bash
   argocd cluster add <context-name>
   ```

## Step 2: Create an ArgoCD Project

Projects in ArgoCD help in grouping your applications.

1. **Define a Project YAML** (`argo-project.yaml`):
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: AppProject
   metadata:
     name: multi-cluster-project
     namespace: argocd
   spec:
     description: Multi-cluster project
     sourceRepos:
       - '*'
     destinations:
       - namespace: '*'
         server: 'https://kubernetes.default.svc'
       # Add other clusters here
     clusterResourceWhitelist:
       - group: '*'
         kind: '*'
   ```

2. **Apply the Project**:
   ```bash
   kubectl apply -f argo-project.yaml
   ```

## Step 3: Create Applications for Each Cluster

Create an application for each cluster with a separate YAML configuration.

1. **Define an Application YAML** (`argo-application.yaml`):
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: sample-app-cluster-1
     namespace: argocd
   spec:
     project: multi-cluster-project
     source:
       repoURL: 'https://your.git.repo/url.git'
       path: path/to/your/k8s/manifests
       targetRevision: HEAD
     destination:
       server: 'https://kubernetes.default.svc' # Change this to the cluster URL
       namespace: your-namespace
     syncPolicy:
       automated:
         selfHeal: true
         prune: true
   ```

2. **Apply the Application**:
   ```bash
   kubectl apply -f argo-application.yaml
   ```

## Step 4: Sync and Manage Applications

Manage and synchronize your applications either through the ArgoCD UI or the CLI.

1. **Sync Applications**:
   ```bash
   argocd app sync sample-app-cluster-1
   ```

2. **Manage Through UI**:
   - Access the ArgoCD UI through a browser.
   - View, manage, and sync applications across clusters.
