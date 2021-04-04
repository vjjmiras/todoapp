#!/bin/sh

echo -n "• Retrieving database container internal IP: "
TODO_DB_SERVICE_PORT=3306
TODO_DB_SERVICE_HOST=$(sudo podman container inspect todo-db -f "{{ .NetworkSettings.IPAddress }}") && \
echo "OK: ${TODO_DB_SERVICE_HOST}"

echo -n "• Launching To Do application: "
sudo podman run -d  --name todo-api                 \
  -e TODO_DB_NAME=items                             \
  -e TODO_DB_USER=user1                             \
  -e TODO_DB_PASSWORD=mypa55                        \
  -e TODO_DB_SERVICE_HOST="${TODO_DB_SERVICE_HOST}" \
  -e TODO_DB_SERVICE_PORT="${TODO_DB_SERVICE_PORT}" \
  -e environment=production                         \
  -p 30080:8080                                     \
  todo-backend &>/dev/null

echo "OK"

echo -n "• API server reachable on "
TODO_API_SERVICE_HOST=$(sudo podman container inspect todo-api -f "{{ .NetworkSettings.IPAddress }}") && \
echo "OK: ${TODO_API_SERVICE_HOST}"
