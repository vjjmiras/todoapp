#!/bin/bash

# Safe execution, clean exit if container already exists
sudo podman container inspect todo-db &>/dev/null 
CONTAINER_EXISTS=$?

if [[ ${CONTAINER_EXISTS} -ne 0 ]]
then
  echo "• todo-db container does not exist" >>/dev/stderr
  exit 0 
fi

# Otherwise
echo -n "• Stopping and removing containers: "
sudo podman stop todo-db
sudo podman rm todo-db
echo "OK"

# if there was a problem with run.sh delete data dir so the database cab be re-initialized:
echo -n "• Removing work directory"
sudo rm -rf work post-init
echo "OK"

