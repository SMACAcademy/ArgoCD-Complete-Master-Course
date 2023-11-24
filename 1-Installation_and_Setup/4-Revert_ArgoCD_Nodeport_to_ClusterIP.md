# Reverting ArgoCD Service from NodePort to ClusterIP

If you have previously configured ArgoCD to be accessible via a NodePort and wish to revert it back to a ClusterIP service, follow the steps below:

## Steps to Revert to ClusterIP

1. **Patch the Service to ClusterIP**
   Use the `kubectl patch` command to revert the service type back to ClusterIP:

   ```sh
   kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "ClusterIP", "ports": [{"port": 80, "targetPort": "http", "nodePort": null}]}}'
   ```

   This command will change the service type back to ClusterIP and remove the node port assignment.

2. **Verify the Change**
   Confirm that the service has been changed back to ClusterIP by running:

   ```sh
   kubectl get svc argocd-server -n argocd
   ```

   The `TYPE` column in the output should now read `ClusterIP` instead of `NodePort`.

3. **Access ArgoCD Internally**
   Once the service is reverted to ClusterIP, it will no longer be accessible from outside the Kubernetes cluster. You can access it internally via:

   ```
   http://argocd-server.argocd.svc.cluster.local
   ```

   If you need external access, consider setting up an ingress or using port forwarding.

## Security Considerations

- Reverting to ClusterIP enhances security by not exposing ArgoCD directly to the internet.
- Ensure that any firewall rules created for NodePort access are updated or removed as necessary.

## Note
The above instructions assume that your Kubernetes cluster uses a standard service configuration. If your cluster uses a different network configuration, additional steps may be required.
