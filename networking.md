# Networking

# Table of Contents
- [Basic Command](#basic-command)
- [Port](#port)
- [Network Interface](#network-interface)
- [Get node Ip](#get-node-ip)
- [MAC address](#mac-address)
- [Default Gateway](#default-gateway)
- [Port Listening](#port-listening)
- [Networking Model](#networking-model)
- [Networking Plugin](#network-plugin)
- [CNI](#cnicontainer-network-interface)
- [Service](#service)
- [Kube-proxy](#kube-proxy)
- [CoreDNS](#coredns)
- [Ingress](#ingress)
# Basic Command
## link
`ip link`
## Addr
`ip addr`
## Add someone to a network
`ip addr add 192.168.1.10/24 dev eth0`
## List route
`ip route`
## Give Access to a network
`ip route add 192.168.1.10/24 via 192.168.2.1`
## IP Forwarding
### Check value
`cat /proc/sys/net/ipv4/ip_forward`
### Enable on the fly
`echo 1 > /proc/sys/net/ipv4/ip_forward`
# Port
Kube-Api: 6443
kubelet: 10250
Kube-scheduler: 10251
Kube-controller-manager:10252
ETCD: 2379
Service: 30000-32767
# Network Interface
`ip link with state UP`
# Get node Ip
`kubectl get nodes -o wide`
# MAC address
## MAC address of the interface on the master node
`ip link show ens3`
## MAC address assigned to node01
`arp node01`
# Default Gateway
`ip route show default`
# Port Listening
`netstat -nplt`
# Networking Model
every pod should have an IP Address.
every pod should have able to communicate with every other pod in the same node.
every pod should be able to communicate every other pod on other nodes without nat.
# Network Plugin
- weave works: install `kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"`
- flannel: install `kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml`
- cilium: install `kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-install.yaml`
- vmware nsx
# CNI(Container Network Interface)
kubelet -> --cni-conf-dir=/etc/cni/net.d -> --cni-bin-dir=/etc/cni/bin -> /net-script.sh add <container> <namespace>
## net-script.sh
ADD)
    # Create veth pair
    # Attach veth pair
    # Assign IP Address
    #Bring Up Interface
    ip -n <namespace> link set ....
DELETE)
    # Delete veth pair
    ip link del ...
## CNI DO
- container Runtime must create network namespace
- identify network the container must attch to
- Container Runtime to invoke Network Plugin ( bridge) when container is Added
- Container Runtime to invoke Network Plugin(bridge) when container is DELeted
- JSON format of the network Configuration
## CNI Configuration
in kubelet.service
--network-plugin=cni
--cni-conf-dir=/etc/cni/net.d
--cni-bin-dir=/etc/cni/bin
or 
ps -aux | grep kubelet
# Service
## Cluster IP
Service can reach all pod on cluster
## Node Port
Service bind a port a worker, now web application can be accessible to the web
# Range of IP addresses configured for PODs on this cluster
kubectl logs weave-net-cjw8q weave -n kube-system | grep ipalloc
# What is the IP Range configured for the services within the cluster?
`cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep cluster-ip-range`
# Kube-proxy
`kubectl logs kube-proxy-ft6n7 -n kube-system`
## Proxy mode: userspace
## Proxy mode: iptables
## Proxy mode: ipvs
# CoreDNS
## Conf file
````shell
cat /etc/coredns/Corefile
kubectl get configmap -n kube-sytem
````
# Ingress
````shell
kubectl get ingress
````
## Resources
Documentation: [here](https://kubernetes.io/docs/concepts/services-networking/ingress/)
Examples: [ingress](templates/ingress.yaml), [ingress-rules](templates/ingress-rule.yaml)
