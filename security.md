all certificate path locate in /etc/kubernetes/manifests/
read ca 
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text
CA = CN Issuer
CN = CN Suject
# lexique
ca = server certificate
certfile = client certificate

# CertificateSigningRequest
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  groups:
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQTMwSENrWTI0bEllT3Nyc0ZTSmppazk4TmtnaGhNU0pGb1ROMUprdVZMVmd4ClVqb2JKQ2pDVkxPYW1wM3NORjU4Z1VHOTVIMUNveHRsR3BPcysvQUt3RUQrSXVEUklZTEZITHozTFhxYWVaUnAKM2NSUGtpR3UzSHB3OXh3eFJyaUlHNGh0ZWZ2b3lHT3phYUFnTXZjdzJkM3BURXBRb3RFbllvcWVNU2dPNjNBTgpKRTFvV2NwV3N6a2M0d2sxTWlaYm13Um90VVpqMTBQeU13cGNPcFc3WmI2bCtFbkV1elduc3lCakxaU0FDdXU0CmxQQUs0OXlTWk5OQ1pYbWc5MW5NL2dkTk9DRjc3M0VNTEMvcDZwbDc0TXoyZVlEY0ViNVVCdnZiS3NCWW84UkkKOEdRWFp3N0NHL1hmQzdFNVVMR1ZJeU9EU1JUdURNb3l4djBQVW9TWCt3SURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBTCtkTWhtWGZOLzdtTStkVEJsMUhneXRsalpESTFXUGxKQVdId0dycTBIMTBDaHBZKzF2CnNjMUdEUmhpUFBuQ0o1V2NkNGJaR0RCVTdGWWhoNklTZ3V4RlRKeko3RkpLeFc2SWIwT3JSWTVobW1aQXlCVTYKdnJJalR3c092cnlPQm1zcVk1dnFDd0lQMUt0SlhHVTNaMWFsZHFtTWJIYzBFS0wyNnM4eDJuVmZzbXdvVmFpVwpXM3hReGkrVjl0YUJNYkVsb282R3ZzQ1RNMXU4bVZEbE1mTWJXOVhLS2lRQWNZUU02RHJSdjJ0M2VvaXE3VElsCjBINjlncGxEME1hR01mMXZzYkcwTzUwNDlFeXI4cy94bklkTFpVeC9naDZYOGZJNGVKQzJ0OXpaZXN6dXNEbTQKQnB6eE9DTk1oWjZjWDFXK3E3NlZzTDRIcTVnR21NdXlibkE9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  usages:
  - digital signature
  - key encipherment
  - server auth

list
kubectl get csr
approve
kubectl certificate approve akshay

# Security Context
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]

# Image registry

kubectl create secret docker-registry private-reg-cred --docker-username=dock_user --docker-password=dock_password --docekr-email=dock_user@myprivateregistry.com --docker-server=myprivateregistry.com:5000

imagePullSecrets:
  - name: private-reg-cred