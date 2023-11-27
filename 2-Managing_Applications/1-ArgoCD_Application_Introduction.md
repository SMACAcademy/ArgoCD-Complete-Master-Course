# ArgoCD Apps Management

## Creating Apps Via UI

To create an ArgoCD application through the UI, use the following repository and path details:

## List all services running in the argocd namespace in minikube.
minikube service --all -n argocd


## Creating Apps Via UI
```
Repo : 
https://github.com/SMACAcademy/argocd-example-apps.git

path : 
guestbook
```

## Creating Apps Via CLI

```
kubectl config set-context --current --namespace=argocd

minikube service --all -n argocd

argocd admin initial-password -n argocd

argocd login 192.168.49.2:30443


argocd app create guestbookcli --repo https://github.com/SMACAcademy/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

argocd app sync guestbookcli

argocd app delete guestbookcli
```
