# Security
**All certificate path locate in /etc/kubernetes/manifests/**
# Table of Contents
- [Read Certificate](#read-certificate)
- [CertificateSigningRequest](#certificatesigningrequest)
- [Security Context](#security-context)
- [Image Registry](#image-registry)
# Read Certificate
`openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text`:
- CA = CN Issuer
- CN = CN Suject
- CA = server certificate
- certfile = client certificate
# CertificateSigningRequest
Full example: [here](templates/certificatesigningRequest.yaml)

## List
`kubectl get csr`
## Approve
`kubectl certificate approve akshay`
# Security Context
````yaml
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]
````
# Image registry
## Create secret Docker-registry
kubectl create secret docker-registry private-reg-cred --docker-username=dock_user --docker-password=dock_password --docekr-email=dock_user@myprivateregistry.com --docker-server=myprivateregistry.com:5000
## Use secret Docker-registry in pod
````yaml
imagePullSecrets:
  - name: private-reg-cred
````
Full example: [here](templates/pod-private-registry.yaml)