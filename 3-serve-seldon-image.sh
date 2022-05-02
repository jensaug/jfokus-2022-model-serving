#!/bin/bash
# Seldon Core Helm Chart and test installation via Articatory on Openshift 4.7

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

IMAGE="${SELDON_REGISTRY}/${SELDON_REPO_OWNER}/sklearn-iris:0.3"

echo "Create SeldonDeployment in $NS_PROJECT based on image $IMAGE"
cat <<EOF | kubectl apply --wait=true -n $NS_PROJECT -f -
apiVersion: machinelearning.seldon.io/v1
kind: SeldonDeployment
metadata:
  name: seldon-image
spec:
  name: seldon-image
  predictors:
  - componentSpecs:
    - spec:
        containers:
        - image: ${IMAGE}
          name: classifier
    graph:
      children: []
      endpoint:
        type: REST
      name: classifier
      type: MODEL
    name: default
    replicas: 1
EOF

# curl -X POST -H 'Content-Type: application/json' \
# -d '{"data": { "ndarray": [[1,2,3,4]]}}' \
# http://seldon-image-default:8000/api/v1.0/predictions

echo "Done!"
