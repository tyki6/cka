# Core Concept


# Table Of Content
- [Architecture](#architecture)
- [Create first app](#create-first-app)
- [Go inside Pod](#go-inside-pod)
- [Go inside container](#go-inside-container)
- [Deploy with yaml](#deploy-with-yaml)
- [Scaling](#scaling)
- [Namespace](#namespace)
- [Context](#context)
- [Label](#label)
# Architecture
Deployment > ReplicatSet > Pod
## Pod
Pods represent the processes running on a cluster. By limiting pods to a single process, Kubernetes can report on the health of each process running in the cluster. Pods have:
- a unique IP address (which allows them to communicate with each other)
- persistent storage volumes (as required)
- configuration information that determine how a container should run.

Shortcut for kubernetes: **pod**
[minimal template for Pod](./templates/pod.yaml)
## ReplicatSet
A ReplicaSet is one of the Kubernetes controllers that makes sure we have a specified number of pod replicas running.

Shortcut for kubernetes: **rs**
## Deployment
A Kubernetes Deployment is used to tell Kubernetes how to create or modify instances of the pods that hold a containerized application. Deployments can scale the number of replica pods, enable rollout of updated code in a controlled manner, or roll back to an earlier deployment version if necessary. 
Shortcut for kubernetes: **deploy**
[minimal template for deployment](./templates/deploy.yaml)

# Create first app
```shell
kubectl create deploy nginx --imgage nginx
# create service to redirect port 
kubectl create service nodeport nginx --tcp 8080:80
# check nginx run
kubectl get pods
# check port 
kubectl get svc
```

# Go inside Pod
```shell
# check pod
kubectl get nodes
# go inside pod
kubectl exec -it nginx-XXXXXXXXXX-XXXXX /bin/bash
# exec command on pod
kubectl exit nginx -- cat /var/log.log
```

# Go inside container
```shell
# check pod
kubectl get nodes
kubectl exec -it nginx-XXXXXXXXXX-XXXXX -c mycontainer /bin/bash
```

# Deploy with yaml
```shell
vim nginx.yaml
kubectl apply -f nginx.yaml
```

# Scaling
## Create Deployment
```shell
kubectl create deploy nginx --imgage nginx
```

## Scaling With Replicas
```shell
kubectl scale deploy nginx --replicas=2
# check 2 pods running
kubectl get pods
```
## Auto Scaling
```shell
kubectl autoscale deploy nginx --min=2 --max=10
```

# Namespace

```shell
kubectl create ns my-first-namespace
kubectl get ns
# -n for precise namespace for create deploy, service
kubectl create deploy nginx -n my-first-namespace --image=nginx 
kubectl get pods
#nothing
kubectl get pods -n my-first-namespace
# now u see your nginx
```

# Context
```shell
kubectl config set-context my-first-context --namespace my-first-namespace --user kubernetes-admin --cluster kubernetes
kubectl config use-context my-first-context
kubectl get pods
```

# Label
```shell
kubectl get pods --all-labels
kubectl label pods nginx-XXXXXXXXX-XXXXXX --overwrite "group=back"
kubectl get pods --selector="group=back" --show-labels
```

# Annotation
same as label