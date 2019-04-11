## Ingress Example

### The ingress controller

We are using the nginx ingress controller from kubernetes here:

```
# apply the manifest directly from github:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/baremetal/service-nodeport.yaml


# use the manifest in the vendor/ directory:
kubectl apply -f vendor/mandatory.yaml
kubectl apply -f vendor/service-nodeport.yaml
```

See https://kubernetes.github.io/ingress-nginx/deploy/ for deployment options at the different cloud providers.


### Steps for testing:

- deploy some service
- deploy a matchin ingress
- send http requests to your ingress URL
