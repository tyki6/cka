# Troubleshooting
# Table of Contents
- [Tips for debug](#tips-for-debug)
- [ControlePane](#controlepane)
- [Network Troubleshooting](#network-troubleshooting)
- [Json Path](#json-path)
# Tips for debug
Documentation: [here](https://kubernetes.io/docs/tasks/debug-application-cluster/troubleshooting/)
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
# ControlePane
```shell
service kube-apiserver status
service kube-controller-manager status
service kube-scheduler status
service kubelet status
service kube-proxy status
kubectl logs kube-apiservice-master -n kube-system

systemclt daemon-reload
systemclt restart kubelet
```
# Network Troubleshooting
- cni-bin-dir:   Kubelet probes this directory for plugins on startup

- network-plugin: The network plugin to use from cni-bin-dir. It must match the name reported by a plugin probed from the plugin directory.

## CoreDns
Kubernetes resources for coreDNS are:   

- a service account named coredns,

- cluster-roles named coredns and kube-dns

- clusterrolebindings named coredns and kube-dns, 

- a deployment named coredns,

- a configmap named coredns

- a service named kube-dns.
# JSON PATH
`kubectl get pods -o json`
`kubectl get pods -o=jsonpath='{.items.*.name}`
## Loop
`kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}["\n"}{end}'`

## Columns
`kubectl get pv --sort-by=.spec.capacity.storage -o=custom-columns=NAME:.metadata.name,CAPACITY:.spec.capacity.storage`