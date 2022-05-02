# Build och push seldon-image
Build a Docker image of this Python source folder with model using Seldon Core S2I. 
It's an optional build: `3-serve-seldon-image.sh` can use existing image `docker.io/jena/seldon-image-sklearn:latest`

## Install S2I
You need to [install s2i](https://github.com/openshift/source-to-image#installation) (or use something like Openshift's `BuildConfig` resource).

## Containerize and push
Use `Podman` or `Docker` and login to your private repository.
```shell
s2i build . seldonio/seldon-core-s2i-python3 docker.io/jena/seldon-image-sklearn:latest
#podman login -u USER -p PASSWORD docker.io
podman push docker.io/jena/seldon-image-sklearn:latest
```