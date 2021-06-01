# PREPARE CKA
# Table of Contents
- [Install Cluster](install_cluster.md)
- [Application](application.md)
- [Core Concept](core_concept.md)
- [Scheduling](scheduling.md)
- [Storage](storage.md)
- [Security](security.md)
- [Network](networking.md)
- [Troubleshooting](troubleshooting.md)
- [Upgrade OS](cluster_maintenance.md)
- [Cluster Maintenance](cluster_maintenance.md)
- [Tips](help.md)  
- [Go Fast](#go-fast)
# Go Fast
## Active autocompletion
```
# Active autocompletion
sudo apt-get install bash-completion -y
sudo echo "source <(kubectl completion bash)" >> ~/.bashrc
source <(kubectl completion bash) && alias k=kubectl && complete -F __start_kubectl k
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
- persistent volume: pv
- persistent volume claim: pvc
- replicaset: rs
- statefulset: sts
- CertificateSigningRequest :csr

# Connect To your cluster
```
vagrant ssh kmaster -c "sudo cat /etc/kubernetes/admin.conf" > ~/.kube/config
# verify 
kubectl get nodes -o wide
```

# Bookmark for cka
[My BookMark For cka](bookmark.html)
Tuto to import Bookmark: https://support.google.com/chrome/answer/96816