# Build, run, push and deploy seldon-java-client
Build a Docker image of this Java source folder with model using Seldon Core S2I.
It's an optional build: `4-deploy-seldon-client.sh` can use existing image `docker.io/jena/seldon-java-client:latest`

## Build and run locally
```shell
mvn clean package
mvn liberty:run
```

## Containerize and push
```shell
podman build -t docker.io/jena/seldon-java-client:latest .
#podman login -u USER -p PASSWORD docker.io
podman push docker.io/jena/seldon-java-client:latest
```

## Deploy in Kubernetes
```shell
kubectl create deployment seldon-java-client --image="docker.io/jena/seldon-java-client:latest" -n a-seldon-project
```