# create first app
```
kubectl create deploy nginx --imgage nginx
# create service to redirect port 
kubectl create service nodeport nginx --tcp 8080:80
# check nginx run
kubectl get pods
# check port 
kubectl get svc
```

# Go inside Pod
```
kubectl get nodes
# check pod name
kubectl exec -it nginx-XXXXXXXXXX-XXXXX /bin/bash
```

# Deploy with yaml
```
cat mondeploy.yaml monservice.yaml > nginx.yaml
kubectl apply -f nginx.yaml
```
# scaling pods
```
kubectl create deploy nginx --imgage nginx
# create service to redirect port 
kubectl create service nodeport nginx --tcp 8080:80
# scaling
kubectl scale deploy nginx --replicas=2
# check 2 pods running
kubectl get pods
# auto scaling
kubectl autoscale deploy nginx --min=2 --max=10
```

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

# Namespace

```
kubectl create ns my-first-namespace
kuectl get ns
# -n for precise namespace for create deploy, service
kubectl create deploy nginx -n my-first-namespace --image=nginx 
kubectl get pods
#nothing
kubectl get pods -n my-first-namespace
# now u see your nginx
```

# Context
```
kubectl config set-context my-first-context --namespace my-first-namespace --user kubernetes-admin --cluster kubernetes
kubectl config use-context my-first-context
kubectl get pods
```

# Label
```
kubectl get pods --all-labels
kubectl label pods nginx-XXXXXXXXX-XXXXXX --overwrite "group=back"
kubectl get pods --selector="group=back" --show-labels
```

# Annotation
same as label