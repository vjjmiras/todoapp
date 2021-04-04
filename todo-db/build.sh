#!/bin/bash

sudo podman build             \
  -t todo-database:latest     \
  -f Dockerfile.todo-database \
  --layers=false

