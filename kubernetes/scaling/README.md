## Scaling with the HPA

The HorizontalPodAutoscaler (HPA) controls the number of replicas based on a metric (e.g. CPU load). It changes the number of running pods to approach the desired metric value. 

### Some synthetic load

This example here provides some synthetic load. A simple apache+php but requests will cause some computation and trigger quire some CPU usage. Here is prepared deployment for that:

```
% kubectl apply -f load-deployment.yaml
```

### The HPA itself

The HPA itself is a K8s Object as well and represents the desired scaling properties:

```
% cat scaler.yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: my-autoscaler
spec:
  maxReplicas: 15
  minReplicas: 2
  scaleTargetRef:
    apiVersion: extensions/v1beta1
    kind: Deployment
    name: load
  targetCPUUtilizationPercentage: 50

% kubectl apply -f scaler.yaml
```

### metrics-server

For getting the necessary metrics you can deploy the metrics-server.
Use the deploy manifests in the `vendor/metrics-server-v0.3.2/deploy` folder or clone the official metrics-server repository:

```
# use from git:
git clone https://github.com/kubernetes-incubator/metrics-server.git
kubectl apply -f metrics-server/deploy/1.8+/

# alternative (use the `vendor/` folder in this repository):
kubectl apply -f vendor/metrics-server-v0.3.2/deploy/1.8+/
```

Also you should now make sure to have correct certificates an CA certificate specified. For simplicity we ignore security in this example:

```
# edit the metrics-server deployment and insert into the metrics-server container:
args: ["--kubelet-insecure-tls"]
```

### Make requests to get load!

```
% kubectl proxy -p 12345 &
% curl http://127.0.0.1:12345/api/v1/namespaces/default/services/load/proxy/
% while sleep .5; do
    echo -n `curl -s http://127.0.0.1:12345/api/v1/namespaces/default/services/load/proxy/`
  done
```

### Observe!

```
% kubectl top pods
% kubectl get hpa
% kubectl describe hpa
```
