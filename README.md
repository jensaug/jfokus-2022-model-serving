# Demo code for the Jfokus 2022 presentation 
"Is The Swedish Tax Agency Ready For The Age Of AI?"

## 0-model-serving-env.sh
Envs used by other scripts, adapt if needed

## 1-install-seldon-core.sh
Installs Seldon Core Operator using above envs

## 2-serve-seldon-model.sh
Creates a SeldonDeployment ML service by referencing a model artifact

## 3-build-seldon-image.sh
Optional S2I build of ML service image

## 3-serve-seldon-image.sh
Creates a SeldonDeployment ML service by referencing an image

## 4-build-java-client.sh
Optional Docker build of Java client

## 4-deploy-java-client.sh
Deploys the Java client for above both ML services

## 5-delete-seldon-core.sh
Deletes all from above scripts
