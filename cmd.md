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
