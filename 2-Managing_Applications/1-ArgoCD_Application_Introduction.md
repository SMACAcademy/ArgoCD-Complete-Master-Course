# ArgoCD Apps Management

## Creating Apps Via UI

To create an ArgoCD application through the UI, use the following repository and path details:

\```
# Repository URL where the application's definition is stored.
Repo: https://github.com/SMACAcademy/argocd-example-apps.git

# The path within the repository where the application's definition can be found.
path: guestbook
\```

## Creating Apps Via CLI

To manage ArgoCD applications via the command line, follow these commands with explanations:

\```
# Set the current kubectl context to the argocd namespace.
kubectl config set-context --current --namespace=argocd

# List all services running in the argocd namespace in minikube.
minikube service --all -n argocd

# Retrieve the initial admin password for ArgoCD.
argocd admin initial-password -n argocd

# Login to ArgoCD server using its IP and port number.
argocd login 192.168.49.2:30443

# Create a new application in ArgoCD with the specified repository, path, destination server, and namespace.
argocd app create guestbookcli --repo https://github.com/SMACAcademy/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

# Synchronize the application state with the desired state in the repository.
argocd app sync guestbookcli

# Delete the application from ArgoCD.
argocd app delete guestbookcli
\```