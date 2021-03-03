# Tips for debug

## check cluster health
check components:
`kubectl get componentstatues`

check daemonsets:
`kubectl get daemonsets -n kube-system`

## Pods
```
kubectl get nodes
kubectl get pods --all-namespace
kubectl get svc
kubectl get deploy
# all resources
kubectl get all
```

**-o wide** for more informations
**-o yaml** for yaml output
## Describe
```
kubectl describe nodes
kubectl describe pods nginx
kubectl describe service nginx
kubectl deploy nginx
```

## Log
```
kubectl logs nginx
# -f for stream
```

## Event 
```
kubectl get events
kubectl get events nginx
``` 