#!/bin/bash

mkdir -p /koinos/block_producer
if [[ ! -f /koinos/block_producer/private.key ]]; then
   koinos_get_dev_key -o /koinos/block_producer/private.key
fi

mkdir -p /koinos/chain
rsync -a -v --ignore-existing /koinos-config/genesis.pub /koinos/chain/genesis.pub

rsync -a -v --ignore-existing /koinos-config/default-config.yml /koinos/config.yml
