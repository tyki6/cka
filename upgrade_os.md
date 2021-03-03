# Detail
kube-apiserver: vX
controller-manager, kube-scheduler: vX-1, vX
kubelet, kube-proxy; vX-2,Vx-1, vX
kubectl: Vx+1, Vx, Vx-1
# Master
kubectl upgrade plan
kubectl upgrade apply

or 

apt-get upgrade -y kubeadm=1.12.0-00
kubectl upgrade plan
kubeadm upgrade apply v1.12.0
apt-get upgrade -y kubelet=1.12.0-00
systemctl restart kubelet

kubectl get nodes -o wide

# Node

kubectl drain node-1 --ignore-daemonset
apt-get upgrade -y kubeadm=1.12.0-00
apt-get install kubelet=1.12.0-00
kubeadm upgrade node config --kubelet-version v1.12.0
systemcl restart kubelet
kubectl uncordon node-1