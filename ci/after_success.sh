#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST_BRANCH" != "" ]; then
  exit 0
fi

TAG="$TRAVIS_BRANCH"
if [ "$TAG" = "master" ]; then
  TAG="latest"
fi

echo "$DOCKER_PASSWORD" | docker login -u $DOCKER_USERNAME --password-stdin
docker push koinos/koinos-docs:$TAG
