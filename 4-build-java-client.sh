#!/bin/bash
# Seldon Core Helm Chart and test installation via Articatory on Openshift 4.7

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

echo "Create SeldonDeployment in $NS_PROJECT based on image"
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
        - image: ${SELDON_REGISTRY}/${SELDON_REPO_OWNER}/mock_classifier:${SELDON_VERSION}
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

echo "Done!"
