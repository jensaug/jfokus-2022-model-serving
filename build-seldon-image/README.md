# Build och push seldon-image
Optional, 3-serve-seldon-image.sh can use existing docker.io/jena/seldon-java-client:latest

## Build and run locally
You need to [install s2i](https://github.com/openshift/source-to-image#installation)
```shell
```

## Containerize and push
```shell
s2i build . seldonio/seldon-core-s2i-python3 docker.io/jena/seldon-image-sklearn:latest
#podman login -u USER -p PASSWORD docker.io
podman push docker.io/jena/seldon-image-sklearn:latest
```