#!/bin/bash

## S2I build and Docker push
# Seldon Core S2I is used for S2I build
# Podman is used for Docker push
# Replace custom repo and user below

cd build-seldon-image/
s2i build . seldonio/seldon-core-s2i-python3 docker.io/jena/seldon-image-sklearn:latest
#podman login -u USER -p PASSWORD docker.io
podman push docker.io/jena/seldon-image-sklearn:latest

echo "Done!"