# Application
this section is for managing lifecycle of your application.update, add conf file, secret or init container.
# Table Of Contents
- [Rollout](#rollback)
- [Environment variables](#environment-variables)
- [ConfigMaps](#configmaps)
- [Secrets](#secrets)
- [Scale](#scale)
- [Init Containers](#init-containers)
# Rollout
Update your application.
## Status
`kubectl rollout status deployment/my-deployment`
## Pause Rollout
`kubectl rollout pause deployment/my-deployment`
## History
`kubectl rollout history deployment/my-deployment`
## RollBack
`kubectl rollout undo deployment/my-deployment`
## Rolling Update Deployment
the Deployment updates Pods in a rolling update fashion when .spec.strategy.type==RollingUpdate. You can specify maxUnavailable and maxSurge to control the rolling update process
- Max Unavailable: is an optional field that specifies the maximum number of Pods that can be unavailable during the update process.
- Max Surge: is an optional field that specifies the maximum number of Pods that can be created over the desired number of Pods.
Example: [here](templates/rolling-update-deployment.yaml)
# Environment variables
## Plain Text
````yaml
env:
  - name: MY_ENV
    value: test
````
Example: [here](templates/pod-with-environment-variable.yaml)
## From Config Map
````yaml
env:
  - name: MY_ENV
    valueFrom: 
      configMapKeyRef:
        name: mymap
        key: username
````
Example: [here](templates/pod-with-environment-variable.yaml)
## From Secret
````yaml
env:
  - name: MY_ENV
    secretKeyRef:
      name: mysecret
      key: username
````
Example: [here](templates/pod-with-environment-variable.yaml)
# ConfigMaps
A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.
commands:
`kubectl create configmap test --from-literal=MY_KEY=MY_VALUE`
Example: [here](templates/configmap.yaml)

Documentation: [here](https://kubernetes.io/docs/concepts/configuration/configmap/)
# Secrets 
Kubernetes Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys.
commands:
`kubectl create secret generic test --from-literal=MY_KEY=MY_VALUE`
Documentation: [here](https://kubernetes.io/docs/concepts/configuration/secret/)
# Scale
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
# Init Containers
When a POD is first created the initContainer is run, and the process in the initContainer must run to a completion before the real container hosting the application starts. 
Example: [here](templates/init-container.yaml)