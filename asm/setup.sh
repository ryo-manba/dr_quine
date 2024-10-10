#!/bin/bash

docker build --platform linux/amd64 -t nasm-env .
docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --rm -it --platform linux/amd64 -v $(pwd):/usr/workspace nasm-env:latest
