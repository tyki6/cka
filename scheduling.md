# Scheduling
A scheduler watches for newly created Pods that have no Node assigned. For every Pod that the scheduler discovers, the scheduler becomes responsible for finding the best Node for that Pod to run on. The scheduler reaches this placement decision taking into account the scheduling principles described below.

# Table Of Content
- [Manual Scheduling](#manual-scheduling)
- [Binding](#binding)
- [Taint & Toleration](#taints--toleration)
- [Node Affinity](#node-affinity)
- [Resource Requirements & Limits](#resource-requirements--limits)
- [DaemonSet](#daemonset)
- [Static Pods](#static-pods)

# Manual Scheduling
If you had nodeName in your pod declaration.you can specify where your pods will be placed.
Example:
````yaml
spec:
  containers:
    - name: test
      image: test
  nodeName: my-node
````
See: [manual-scheduling.yaml](templates/manual-scheduling.yaml)
# Binding
an entity for bindings a specific pods to a specific node target.
See: [binding.yaml](templates/binding.yaml)
# Taints & Toleration
Tolerations are applied to pods, and allow (but do not require) the pods to schedule onto nodes with matching taints.
Documentation: [here](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
## Command
kubectl taint node NAME KEY_1=VAL_1:TAINT_EFFECT_1 ... KEY_N=VAL_N:TAINT_EFFECT_N
## Taint Effect
- NoSchedule: no pod will be able to schedule onto node
- PreferNoSchedule: soft version of NoSchedule, he system will try to avoid placing a pod that does not tolerate the taint on the node, but it is not required.
- NoExecute: pod will be evicted from the node (if it is already running on the node), and will not be scheduled onto the node
## Remove Taint
Add - to your last command
Example:
if your taint command is: 
- `kubectl taint nodes node1 key1=value1:NoSchedule`

remove taint command:
- `kubectl taint nodes node1 key1=value1:NoSchedule-`
## Toleration
You specify a toleration for a pod in the PodSpec. 
Both of the following tolerations "match" the taint created by the kubectl taint line above, and thus a pod with either toleration would be able to schedule onto node1
Example:
`kubectl taint nodes node1 key1=value1:NoSchedule`
````yaml
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"
````
With this toleration your pods can be scheduled on node1.
##Use Cases
- Dedicated Nodes
- Nodes with Special Hardware
- Taint based Evictions
# Node Affinity
You can constrain a Pod to only be able to run on particular Node(s), or to prefer to run on particular nodes
## Types
- requiredDuringSchedulingIgnoredDuringExecution 
- preferredDuringSchedulingIgnoredDuringExecution 
- requiredDuringSchedulingRequiredDuringExecution 
## Example
````yaml
affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: my-key
            operator: In
            values:
            - test
            - test2
````
Full Example: [here](templates/node-affinity.yaml)
Documentation: [here](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity)
# Resource Requirements & Limits
Documentation: [here](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
## Request
Resources requested for a **container**
Example:
````yaml
resources:
  requests:
    memory: "1Gi"
    cpu: 1
````
Full Example: [here](templates/resource-limits.yaml)
## Limits
Limits for a **container**, if a container exceeds limits pods will state to terminating
Example:
````yaml
resources:
  limits:
    memory: "1Gi"
    cpu: 1
````
Full Example: [here](templates/resource-limits.yaml)
# DaemonSet
In a simple case, one DaemonSet, covering all nodes
Some typical uses of a DaemonSet are:
- running a cluster storage daemon on every node
- running a logs collection daemon on every node
- running a node monitoring daemon on every node

Shortcut for kubernetes: **ds**
[minimal template for DaemonSet](./templates/daemonset.yaml)
Documentation: [here](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
# Static Pods
All Static pods are located in pod-manifest directory path of this directory is described on kubelet.service or in kubeconfig.yaml with staticPodPath
Path: /etc/kubernetes/manifests
Documentation: [here](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/)
## DaemonSet Vs Static Pods
static pods are created by kubelet, it's used to deploy control Plane components as static pods
DaemonSets created by Kube-api-server, used to deploy Monitoring Agents, Logging Agents on nodes
Both are ignored b the Kube-Scheduler