
# kubectl port-forward Commands

Here are various `kubectl port-forward` command options you can use in Kubernetes:

1. **Basic Port Forwarding**:
   ```bash
   kubectl port-forward pod/my-pod 8080:80
   ```

2. **Forward Multiple Ports**:
   ```bash
   kubectl port-forward pod/my-pod 8080:80 8443:443
   ```

3. **Use a Random Local Port**:
   ```bash
   kubectl port-forward pod/my-pod :80
   ```

4. **Specify a Namespace**:
   ```bash
   kubectl port-forward -n my-namespace pod/my-pod 8080:80
   ```

5. **Listen on All Interfaces**:
   ```bash
   kubectl port-forward --address 0.0.0.0 pod/my-pod 8080:80
   ```

6. **Listen on a Specific IP Address**:
   ```bash
   kubectl port-forward --address 192.168.1.100 pod/my-pod 8080:80
   ```

7. **Port Forwarding to a Service**:
   ```bash
   kubectl port-forward svc/my-service 8080:80
   ```

8. **Run in the Background**:
   ```bash
   kubectl port-forward pod/my-pod 8080:80 &
   ```

9. **Forward a Range of Ports**:
   ```bash
   kubectl port-forward pod/my-pod 8000-8003:80-83
   ```

10. **Use with Deployment or ReplicaSet**:
   ```bash
   kubectl port-forward deployment/my-deployment 8080:80
   kubectl port-forward rs/my-replicaset 8080:80
   ```
