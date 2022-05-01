# Build och deploy seldon-java-client

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
kubectl create deployment seldon-java-client --image="docker.io/jena/seldon-java-client:latest" 
```