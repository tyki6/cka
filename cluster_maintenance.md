# Cluster Maintenance
# Table of Contents
- [Detail](#detail)
- [Upgrade Os Master](#upgrade-os-master)
- [Upgrade Os Node](#upgrade-os-node)  
- [Save ETCD](#save-etcd)
- [Restore ETCD](#restore-etcd)
# Detail
kube-apiserver: vX
controller-manager, kube-scheduler: vX-1, vX
kubelet, kube-proxy; vX-2,Vx-1, vX
kubectl: Vx+1, Vx, Vx-1
# Upgrade OS Master
````shell
kubectl upgrade plan
kubectl upgrade apply
````
or 
````shell
apt-get upgrade -y kubeadm=1.12.0-00
kubectl upgrade plan
kubeadm upgrade apply v1.12.0
apt-get upgrade -y kubelet=1.12.0-00
systemctl restart kubelet

kubectl get nodes -o wide
````
# Upgrade OS Node
````shell
kubectl drain node-1 --ignore-daemonset
apt-get upgrade -y kubeadm=1.12.0-00
apt-get install kubelet=1.12.0-00
kubeadm upgrade node config --kubelet-version v1.12.0
systemcl restart kubelet
kubectl uncordon node-1
````
# Save ETCD
````shell
ETCDCTL_API=3 etcdctl snapshot save snapeshot.db

ETCDCTL_API=3 etcdctl --endpoints=https://[Master-IP]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot save /opt/snapshot-pre-boot.db
````
# Restore ETCD
````shell
service kube-apiserver stop
ETCDCTL_API=3 etcdctl snapshot restore snapeshot.db --data-dir path
sytemctl daemon-reload
service etcd restart
service kube-apiserver start
````