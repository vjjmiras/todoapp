#!/bin/sh

# If no other image is specified, the one from RHSCL will be used
# i.e. ./start.sh do180/todo-db:latest
CONTAINER_IMAGE=${1:-registry.access.redhat.com/rhscl/mysql-57-rhel7}


# Safe execution, clean exit if container already exists
MYSQL_IPADDR=$(sudo podman container inspect todo-db -f '{{ .NetworkSettings.IPAddress }}' 2>/dev/null)
CONTAINER_EXISTS=$?

if [[ ${CONTAINER_EXISTS} -eq 0 ]]
then
  echo "• todo-db container is running already on ${MYSQL_IPADDR}" >/dev/stderr
  exit -1
fi


echo -n "• Creating database volume: "

if [ -d "work" ]; then
  sudo rm -fr work &>/dev/null
fi

if [ -d "post init" ]; then
  sudo rm -fr post-init &>/dev/null
fi

mkdir -p work/init work/data
cp db.sql work/init
cp -r mysql-init post-init
sudo chcon -Rt container_file_t work post-init
sudo chown -R 27:27 work post-init

echo "OK"

echo -n "• Starting database: "
# Podman run for mysql image here
sudo podman run -d --name todo-db                     \
  -e MYSQL_ROOT_PASSWORD=r00tpa55                     \
  -e MYSQL_USER=user1                                 \
  -e MYSQL_PASSWORD=mypa55                            \
  -e MYSQL_DATABASE=items                             \
  -v $PWD/post-init:/opt/app-root/src/mysql-init      \
  -v $PWD/work/data:/var/lib/mysql/data               \
  -v $PWD/work/init:/var/lib/mysql/init               \
  ${CONTAINER_IMAGE}                                  >/dev/null

echo "OK"

echo -n "• Retrieving database container internal IP: "
TODO_DB_SERVICE_HOST=$(sudo podman container inspect -l -f "{{.NetworkSettings.IPAddress}}") && \
echo "OK: ${MYSQL_SERVICE_HOST}"

