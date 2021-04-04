#!/bin/bash

SRC_CONTENT="index.html hello.html css lib script"

# Cleanup
rm -fr build &>/dev/null

# Prepare artifacts to build image
mkdir -p build
cp -ap ${SRC_CONTENT} build/
rm build/*.sh &>/dev/null
chmod -R a+rwX build

# Build podman image
sudo podman build             \
  -t todo-frontend            \
  -f Dockerfile.todo-frontend \
  --layers=false
