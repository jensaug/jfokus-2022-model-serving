#!/bin/bash
# Seldon Core Helm Chart and test installation via Articatory on Openshift 4.7

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

echo "Create SeldonDeployment in $NS_PROJECT based on model"
cat <<EOF | kubectl apply --wait=true -n $NS_PROJECT -f -
apiVersion: machinelearning.seldon.io/v1
kind: SeldonDeployment
metadata:
  name: seldon-model
spec:
  name: seldon-model
  predictors:
  - graph:
      modelUri: ${SELDON_MODEL_STORE}/v${SELDON_VERSION}/sklearn/iris
      implementation: SKLEARN_SERVER
      name: classifier
    name: default
    replicas: 1
EOF

# curl -X POST -H 'Content-Type: application/json' \
# -d '{"data": { "ndarray": [[1,2,3,4]]}}' \
# http://seldon-model-default:8000/api/v1.0/predictions

echo "Done!"
