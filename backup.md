# Backup 
kubectl get all --all-namespaces -o yaml > all.yaml

#etcd
ETCDCTL_API=3 etcdctl snapshot save snapeshot.db

ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot save /opt/snapshot-pre-boot.db

# Restore
service kube-apiserver stop
ETCDCTL_API=3 etcdctl snapshot restore snapeshot.db --data-dir path
sytemctl daemon-reload
service etcd restart
service kube-apiserver start