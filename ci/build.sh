#!/bin/bash

set -e
set -x

TAG="$TRAVIS_BRANCH"
if [ "$TAG" = "master" ]; then
  TAG="latest"
fi

docker build --no-cache --build-arg -t koinos/koinos-docs:$TAG .
