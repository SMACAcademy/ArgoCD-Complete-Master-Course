
# Installation of Argo CD and Argo CD CLI

This guide will outline the steps to install Argo CD on a Kubernetes cluster and set up the Argo CD CLI on your local machine. Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

## Create Argo CD Namespace

```bash
kubectl create namespace argocd
```

This command creates a dedicated namespace in your Kubernetes cluster for Argo CD.

## Install Argo CD

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get all --namespace=argocd
```

This applies the Argo CD installation manifest from the official Argo project repository to your cluster within the `argocd` namespace.

## Install Argo CD CLI

```bash
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```

These commands will download the latest Argo CD CLI binary, set the necessary permissions, move it to your local binary path for global access, and then remove the downloaded file.

## Accessing Argo CD Services

```bash
kubectl get svc -n argocd
kubectl port-forward svc/argocd-server 8080:443 -n argocd
kubectl port-forward --address 0.0.0.0 svc/argocd-server 8080:443 -n argocd
```

Retrieve the list of services running for Argo CD and forward the `argocd-server` service port to access the Argo CD server locally at `localhost:8080`.  If access from remote host is required, then SSH tunnel to be opened or add the option `--address 0.0.0.0` to allow request forward to work from all hosts.

## Initial Argo CD Login

```bash
argocd admin initial-password -n argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo


argocd login localhost:8080
argocd cluster list
argocd app list
```

Get the initial password for the Argo CD admin account and use the CLI to log in to the Argo CD server.

## Logout of Argo CD

```bash
argocd logout localhost:8080
```


## Cleanup

### Delete the Argo CD Namespace

```bash
kubectl delete ns argocd
```

This command will delete the entire `argocd` namespace, effectively removing Argo CD and all related resources from your Kubernetes cluster.

After completing these steps, Argo CD will be installed on your Kubernetes cluster, and you will have the Argo CD CLI installed on your machine, ready for managing your applications.
