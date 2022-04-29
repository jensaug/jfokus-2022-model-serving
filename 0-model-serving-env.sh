#!/bin/bash
# Seldon Core Helm Chart and test deletion

echo "Validating arguments..."
NS_PREFIX=$1

echo "Setting shell variables..."
if [ -z "$NS_PREFIX" ]
  then
    NS_OPERATOR=a-seldon-system
    NS_PROJECT=a-seldon-project
  else
    NS_OPERATOR=$NS_PREFIX-system
    NS_PROJECT=$NS_PREFIX-project
fi
SELDON_HELM_REPO="https://storage.googleapis.com/seldon-charts/"
SELDON_REGISTRY="docker.io"
SELDON_REPO_OWNER="seldonio"
SELDON_VERSION="1.13.1"
SELDON_MODEL_STORE="gs://seldon-models"
USER_ID=
PROMETHEUS_PATH="/prometheus"
TENSORFLOW_IMAGE=-"tensorflow/serving"
TRITON_IMAGE="nvcr.io/nvidia/tritonserver"
SELDON_JAVA_CLIENT_IMAGE="docker.io/jena/seldon-java-client:latest"