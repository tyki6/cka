# Basic Pod
```
kind: Pod
metadata:
  name: monpod
  # définition du namespace
  namespace: xavki
  # labels
  labels:
    env: prod

spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  - name: mondebian
    image: debian
    command: ["sleep", "600"]
```
# Basic keyword
- kind: type of resource
- metadata: name(required), labels(optional), namespace(optional)
- spec: specification
    - containers:type lit
        - name, image, command, port etc.... like docker
