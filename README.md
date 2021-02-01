# PREPARE CKA

# Pre-requis
- virtualbox (`sudo apt-get install virtualbox -y`)
- vagrant (`sudo apt-get install vagrant -y`)

# Install Cluster 1 master, 2 nodes
```
vagrant up
```
## Verif install
```
vagrant ssh master
sudo -s
kubectl get nodes
# kmaster ready, roles: control-plane, master
# knode{1,2} ready, roles: none
kubectl get pod
# all pods ready(2 core, 1 apiserver, 3 flannel, 3proxy, 1 scheduler)
```