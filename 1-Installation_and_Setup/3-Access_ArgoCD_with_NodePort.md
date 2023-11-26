# Accessing ArgoCD Using NodePort

ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes. To access the ArgoCD UI using a NodePort, you can follow these steps:

## Prerequisites
- Ensure you have `kubectl` installed and configured to communicate with your Kubernetes cluster.
- Ensure ArgoCD is installed on your Kubernetes cluster.

## Steps to Access ArgoCD UI

1. **Find or Create the NodePort Service**
   If ArgoCD is not already exposed via a NodePort, you will need to create or patch the service.

   - **Creating a NodePort Service via YAML**:
     Save the following configuration to a file, e.g., `argocd-server-nodeport.yaml`:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: argocd-server-nodeport
       namespace: argocd
     spec:
       type: NodePort
       ports:
         - port: 80
           targetPort: 8080
           nodePort: 30007 # Specify the nodePort you want to use, or let Kubernetes allocate one for you.
       selector:
         app.kubernetes.io/name: argocd-server
     ```
     Apply it with the command:
     ```sh
     kubectl apply -f argocd-server-nodeport.yaml
     ```

   - **Using `kubectl patch` Command**:
     To quickly change the service type to NodePort and let Kubernetes allocate an available port, you can use the following command:
     ```sh
     kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
     kubectl get svc -n argocd

     minikube ip


     ```
     If you want to specify a particular node port, use the following command, replacing `<node_port>` with your chosen port number:
     ```sh
     kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort", "ports": [{"nodePort": <node_port>, "port": 80}]}}'
     ```

   - **Manually Editing the Service**:
     Alternatively, you can manually edit the service with the following command, which will open the service definition in an editor:
     ```sh
     kubectl edit svc argocd-server -n argocd
     ```
     In the editor, change `type: ClusterIP` to `type: NodePort`. Optionally, you can also specify `nodePort: <node_port>` under the `ports` section if you want to use a specific port.

2. **Get the Node IP and Port**
   Retrieve the NodePort assigned to the ArgoCD service and the IP address of any of your cluster's nodes using the following commands:
   ```sh
   kubectl get svc argocd-server -n argocd
   kubectl get nodes -o wide
   ```

3. **Access the ArgoCD UI**
   Navigate to `http://<node-ip>:<node-port>` in a web browser, replacing `<node-ip>` with your node's IP address and `<node-port>` with the NodePort assigned to the ArgoCD service.

4. **Login to ArgoCD**
   The default username is 'admin', and the password is auto-generated. Retrieve it using:
   ```sh
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
   ```

## Security Considerations

- NodePort services are exposed externally, which could be a security risk. Use an ingress with HTTPS and authentication for production environments.
- Ensure your firewall rules allow traffic to the node port.
- For production use, consider a `LoadBalancer` service or an `Ingress` controller with SSL/TLS certificates.

## Note
The above instructions assume that your Kubernetes cluster uses a standard NodePort configuration. If your cluster is behind a firewall or uses a different network configuration, additional steps may be required to access the ArgoCD UI.
