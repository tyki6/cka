# Install Cluster
# Table of Contents
- [Pre-requis](#pre-requis)
- [Install Cluster](#install-cluster-1-master-2-worker-with-vagrant)
- [Verify Installation](#verify-installation)
- [Sources](#sources)
# Pre-requis
- virtualbox (`sudo apt-get install virtualbox -y`)
- vagrant (`sudo apt-get install vagrant -y`)
# Install Cluster 1 master, 2 worker with Vagrant
```shell
vagrant up
```
# Verify Installation
```shell
vagrant ssh master
sudo -s
kubectl get nodes
# kmaster ready, roles: control-plane, master
# knode{1,2} ready, roles: none
kubectl get pod
# all pods ready(2 core, 1 apiserver, 3 flannel, 3proxy, 1 scheduler)
```

# Sources
## Master Script
- step 1: run script/install_common.sh for install kubelet / kubeadm / kubectl / kubernetes-cni / docker
- step 2: run script/install_master for setup kubadm / flannel
## Worker Script
- step 1: run script/install_common.sh for install kubelet / kubeadm / kubectl / kubernetes-cni / docker
- step 2: run script/install_master for setup kubelet / join master node