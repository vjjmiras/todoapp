#!/bin/bash

echo -n "• Deleting containers: "
sudo podman stop todo-api &>/dev/null
sudo podman rm todo-api &>/dev/null
echo "OK"

# echo -n "• Deleting network: "
# sudo podman network rm do180-app-bridge &>/dev/null
# echo "OK"
