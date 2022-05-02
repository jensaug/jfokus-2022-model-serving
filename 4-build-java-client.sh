#!/bin/bash

## Java build and Docker build+push
# Maven is used for Java build
# Podman is used for Docker build+push
# Replace custom repo and user below

cd java-client/
mvn clean package
podman build -t docker.io/jena/seldon-java-client:latest . # Replace with custom
#podman login -u USER -p PASSWORD docker.io # Replace with custom
podman push docker.io/jena/seldon-java-client:latest # Replace with custom

echo "Done!"
