#!/bin/bash

# Nexus Repository can be passed as a parameter
# i.e. NEXUS_BASE_URL=https://nexus-common.apps.eu45.prod.nextcle.com ./build.sh 
NEXUS_BASE_URL=${NEXUS_BASE_URL:-nexus-common.apps.eu45.prod.nextcle.com}

SRC_CONTENT="app.js package.json controllers/ models/"

# Cleanup
rm -fr build &>/dev/null

# Prepare artifacts to build image
mkdir -p build
cp -ap ${SRC_CONTENT} build/
rm build/*.sh &>/dev/null
chmod -R a+rwX build

# Build podman image
sudo podman build -t do180/todo-api -f Dockerfile.todo-api # --build-arg NEXUS_BASE_URL=${NEXUS_BASE_URL}
