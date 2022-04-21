#!/bin/bash
# Seldon Core Helm Chart and test installation via Articatory on Openshift 4.7

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

echo "==="
echo "Installing Seldon Core Operator on Openshift in namespace $NS_OPERATOR using Helm Chart in $SELDON_HELM_REPO"
echo "Depends on Helm 3.7, tested using kubectl 1.16, openshift 4.7 (logged in cluster admin) and Seldon Core 1.7"
echo "Remove all by running 6-delete-seldon.sh"
echo "==="

# Verify Helm installation
if ! command -v "helm" &> /dev/null
then
    echo "helm is not installed"
    echo "Install latest from https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest"
    exit
fi

echo "Handle namespaces"
kubectl create namespace $NS_OPERATOR
kubectl create namespace $NS_PROJECT

echo "Install Seldon Operator using Helm in $NS_OPERATOR"
helm install seldon-core-operator seldon-core-operator \
--namespace $NS_OPERATOR \
--repo=$SELDON_HELM_REPO \
--version=$SELDON_VERSION \
--wait \
--set ambassador.enabled=false \
--set defaultUserID=$USER_ID \
--set engine.image.registry=$SELDON_REGISTRY \
--set engine.prometheus.path=/metrics \
--set engine.user=$USER_ID \
--set executor.image.registry=$SELDON_REGISTRY \
--set executor.prometheus.path=/metrics \
--set executor.user=$USER_ID \
--set image.pullPolicy=IfNotPresent \
--set image.registry=$SELDON_REGISTRY \
--set managerUserID=$USER_ID \
--set predictor_servers.TENSORFLOW_SERVER.protocols.tensorflow.image=$TENSORFLOW_IMAGE \
--set predictor_servers.TRITON_SERVER.protocols.kfserving.image=$TRITON_IMAGE \
--set usageMetrics.enabled=false \

echo "Done!"
