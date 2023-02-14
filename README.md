# Koinos

The Koinos Blockchain consists of multiple interdependent microservices that communicate via AMQP. Each microservice has been dockerized and can easily be run as a unit with Docker Compose.

Images are automatically uploaded to [Docker Hub](https://hub.docker.com/u/koinos). `latest` tracks `master` on each microservice repo. Feature branches are uploaded with their branch name as the image tag.

## Install Docker Compose

Koinos requires Compose V2. The latest version of Docker Deskop on Linux, Mac, and Windows all support Compose V2.

Depending on your Linux distribution, you may need to install the compose plugin for Compose V2 support (Ubuntu 22.04 requires this).

All installation instructions for Docker Desktop and the Compose plugin for all platforms can be found [here](https://docs.docker.com/compose/install/).

## Configure Koinos

Koinos is a blockchain framework and can be used to launch an infinite number of unique blockchains. In order to run a specific blockchain, the Koinos node must first be configured. `config-example` and `env.example` contain suitable defaults to connect to the Koinos mainnet. Copy `config-example` to `config` and `env.example` to `.env` to use the defaults. If you are updating your node, the examples will always contain updated defaults that you can copy in to our config at your discretion.

Inside the `config` directory are four config files, `config.yml`, `genesis_data.json`, `koinos_descriptors.pb`, and `rabbitmq.conf`. Below are descriptions of each.

`config.yml` directly configures the Koinos microservices. Options in the global namespace apply to all microservices. Options under a specific microservice apply just to that microservice. Many options, such as `log`, are the same across all microservices to allow configuration in the global namespace as well as microservice specific overrides.

`genesis_data.json` is the initial genesis state of the blockchain (block 0). This sets important system variables such as the genesis public key to boot the blockchain. The hash of all the genesis data is called the Chain ID. The Chain ID is used to quickly differentiate between different blockchains. This file should never be changed.

`koinos_descriptors.pb` is an encoded representation of all Koinos Protocol Buffers definitions. It is used by the JSON RPC microservice to service API calls. This file should be updated with new versions but not manually editted.

`rabbitmq.conf` is the configuration file for the AMQP microservice. It can be modified, but is recommended only advanced users modify this file.

By default, each container will use `~/.koinos` on the host as their base directory. This can be changed by setting `BASEDIR` in `.env`, or exporting `BASEDIR` as an environment variable, to a different location on the host machine.

Different images can be run by setting environment variables or setting them in `.env`. For each microservice, append `_TAG` (e.g. `export P2P_TAG=64-auto-gossip`).

By default the node will only run core required microservices (chain, block_store, mempool, and p2p).

You can run optional microservices by enabling the associated docker compose profiles:

 - `block_producer` to enable the block production.
 - `jsonrpc` to enable JSON-RPC API handling.
 - `transaction_store` to enable transaction history tracking.
 - `account_history` to enable account history tracking.
 - `contract_meta_store` to enable tracking of smart contract metadata.

These profiles can be set with the `--profile` options (i.e. `docker compose --profile api up `) or by setting the `COMPOSE_PROFILES` environment variable during invocation or in `.env`.

For more information on docker compose profiles, please read the official [documentation](https://docs.docker.com/compose/profiles/).

## Running Koinos

Once docker compose is installed and the node configured, run `docker compose up -d` to start the node as a daemon.

To check on the node run `docker compose logs --tail 1 --follow` to display logs for the node.

The node will automatically start upon system restart. To stop the node, run `docker compose down`.
