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

# Go Fast
## Active autocompletion
```
# Active autocompletion
sudo apt-get install bash-completion -y
sudo echo "source <(kubectl completion bash)" >> ~/.bashrc
```

## alias
```
alias k='kubectl'
alias kcc='kubectl config current-context'
alias kg='kubectl get'
alias kga='kubectl get all --all-namespaces'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias ksgp='kubectl get pods -n kube-system'
alias kuc='kubectl config use-context'
```
## shortcut
- service: svc
- deployment: deploy
- namespace: ns
# Connect To your cluster
```
vagrant ssh kmaster -c "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config
# verify 
kubectl get nodes -o wide
```