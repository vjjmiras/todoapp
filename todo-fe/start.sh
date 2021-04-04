#!/bin/sh

echo -n "• Retrieving API container internal IP: "
# TODO_API_SERVICE_PORT=8080
# TODO_API_SERVICE_HOST=$(sudo podman container inspect todo-api -f "{{ .NetworkSettings.IPAddress }}") && \

TODO_API_SERVICE_PORT=30080
TODO_API_SERVICE_HOST=workstation.lab.example.com
echo "OK: ${TODO_API_SERVICE_HOST}"

echo -n "• Launching To Do application: "
sudo podman run -d  --name todo-fe                \
  -e TODO_API_SERVICE_HOST="${TODO_API_SERVICE_HOST}" \
  -e TODO_API_SERVICE_PORT="${TODO_API_SERVICE_PORT}" \
  -p 30000:8080 \
  todo-frontend &>/dev/null
echo "OK"

echo -n "• TODO App Front End reachable on "
TODO_FE_SERVICE_HOST=$(sudo podman container inspect todo-fe -f "{{ .NetworkSettings.IPAddress }}") && \
echo "OK: ${TODO_FE_SERVICE_HOST}"
