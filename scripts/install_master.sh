#!/bin/bash

## install master for k8s

TOKEN="abcdef.0123456789abcdef"
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $2}')
echo "START - install master - "$IP

echo "[0]: reset cluster if exist"
kubeadm reset -f

echo "[1]: kubadm init"
kubeadm init --apiserver-advertise-address=$IP --token="$TOKEN" --pod-network-cidr=10.244.0.0/16

echo "[2]: create config file"
mkdir $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config

echo "[3]: create flannel pods network"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml

echo "[4]: restart and enable kubelet"
systemctl enable kubelet
service kubelet restart

echo "END - install master - " $IP
