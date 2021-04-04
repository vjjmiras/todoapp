#!/bin/bash

sudo podman build -t do180/todo-db:latest -f Dockerfile.todo-db .
