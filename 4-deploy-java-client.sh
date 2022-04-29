#!/bin/bash
# Seldon Core Helm Chart and test installation via Articatory on Openshift 4.7

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

echo "Deploy Java client in $NS_PROJECT"
cat <<EOF | kubectl apply --wait=true -n $NS_PROJECT -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: seldon-java-client
  labels:
    app: system
spec:
  selector:
    matchLabels:
      app: system
  template:
    metadata:
      labels:
        app: system
    spec:
      containers:
      - name: system-container
        image: $SELDON_JAVA_CLIENT_IMAGE
        ports:
        - containerPort: 9080
---
apiVersion: v1
kind: Service
metadata:
  name: seldon-java-client
spec:
  type: NodePort
  selector:
    app: system
  ports:
  - protocol: TCP
    port: 9080
    targetPort: 9080
    nodePort: 31000
---
EOF

#curl seldon-java-client:9080/system/properties

echo "Done!"
