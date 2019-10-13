#!/usr/bin/env bash

docker run -it \
  --rm \
  --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/devops-school-tmp:/var/devops_school_directory \
  --user $(id -u) \
  devops_school:3.1-base
