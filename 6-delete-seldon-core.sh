#!/bin/bash
# Seldon Core Helm Chart and project deletion

# Source in environment variables
set -o allexport
source 0-model-serving-env.sh
set +o allexport

echo "Deleting Seldon Core Operator from Openshift in namespace $NS_OPERATOR"


echo "Trying to uninstall Helm Chart and test namespace"
helm uninstall seldon-core-operator --namespace $NS_OPERATOR

echo "Handle namespaces"
kubectl delete --wait namespace $NS_PROJECT
kubectl delete --wait namespace $NS_OPERATOR

#echo "Delete ClusterRole with Bindings for Seldon"
#kubectl delete clusterrolebinding -l app=seldon
#kubectl delete clusterrole -l app=seldon
#kubectl delete validatingwebhookconfigurations -l app=seldon
#kubectl delete rolebinding seldon-webhook-rolebinding-seldon-system #TODO: move to NS

#echo "Delete Custom Resource Definition för SeldonDeployment"
#kubectl delete crd seldondeployments.machinelearning.seldon.io

echo "Done!"