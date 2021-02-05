# Kubernetes

- pod: 1 or many docker
- deployment: 1 or many pods(conf)
- service: access to pods
- daemonsets: pods running in background
- namespace: group of pods
- context: profil
- label: in kubernetes (selector)
- annotation: out kubernetes 
- liveness: auto restart
- readiness: replace pods
- persistent volume
- replicaset: Type of deployment, instance fix of pods
- configmap: configuration file

# Service
- nodeport: redirect to public port (range 30000-32767)
- clusterip: internal
- loadBalancerip: cloud or ingress controler
- externalname: url
# Liveness & Readiness
## Modes
- command: exec
- http: httpGet
- tcp: tcpSocket
## Variables
- initialDelaySeconds: how can you start check?now? 10sec, 20sec, etc...
- periodSeconds: frequencies
- timeoutSeconds: number of second for timeout
- successThreshold: number of success for reactive container
- failureThreshold: numer of failure for disable container
## HttpGet
- host
- scheme
- path
- httpHeaders
- port
# Example 
```
readinessProbe:
  httpGet:
    path: /monitoring/alive
    port: 3401
  initialDelaySeconds: 5
  timeoutSeconds: 1
  periodSeconds: 15
livenessProbe:
  httpGet:
    path: /monitoring/alive
    port: 3401
    initialDelaySeconds: 15
    timeoutSeconds: 1
    periodSeconds: 15

```

# Volume
## types
- emptyDir: no persistent, share between pods
- hostpath: 
- persistent volume claim
- extern: nfs for example

## Persistent Volume
`kubectl get pv`
pv > pvc > pods
`kubectl get pvc`
### AccessLodes
- ReadWriteOnce
- ReadOnlyMany
- ReadWriteMany

# ReplicaSet
- spec
 - replicas: int
 - selector:
  - matchLabels:
  
- template:
 - metadata:
    labels
 - spec
 
If you delete one pods, new pods will be recreate.

# Config Map

## CLi
- --from-literal: enter key value in ci
- --from-file: get file
```
kubectl create configmap langue --from-literal=LANGUE=FR
kubectl get configmaps langue
kubectl describe configmaps langue
```
### Edit
`kubectl edit configmaps langue`
## Use ConfigMap
## configMapKeyRef
```yaml
envFrom:
  - configMapKeyRef:
      name: langue
```
```yaml
env:
  - name: langue
    valueFrom:
      configMapKeyRef:
        name: langue
        key: LANGUE
```
## Volume
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: monpod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /usr/share/nginx/html/
      name: monvolumeconfig
  volumes:
  - name: monvolumeconfig
    configMap:
      name: personne
      items:
      - key: clef
        path: index.html
```
# Secrets
## CLi
- --from-literal: enter key value in ci
- --from-file: get file
```
kubectl create secrets mypasword --from-literal=LANGUE=FR
kubectl get secrets mypasword
kubectl describe secrets mypasword
```
### Edit
`kubectl edit secrets langue`

# Deployment 

## Rolling Update
```yaml
strategy:
 type: RollingUpdate
 rollingUpdate:
   maxSurge: 2
   maxUnavailable: 0
```
other parameters:
- minReadySeconds
- progressDeadLineSeconds: deployment time max else deployment will fail
- revisionHistoryLimit: history length

# Rollout
`kubectl rollout status deployments`
`kubectl rollout history deployment`
`kubectl rollout undo deployment --to-revision 2`

# StatefulSet
for bdd or app that need persistence