# Koinos

The Koinos Blockchain consists of multiple interdependent microservices that communicate via AMQP. Each microservice has been dockerized and can easily be run as a unit with Docker Compose.

Images are automatically uploaded to [Docker Hub](https://hub.docker.com/u/koinos). `latest` tracks `master` on each microservice repo. Feature branches are uploaded with their branch name as the image tag.

## Install Docker Compose

You will need to install Docker on MacOS or Windows first . You can follow their instructions for installation [here](https://www.docker.com/products/docker-desktop). Docker desktop comes with a recent version of docker-compose.

You may need to upgrade your version of docker-compose on Linux. Ubuntu 20.04 does not come with a recent enough version. Your mileage may vary depending on your distribution. You can follow the official [installation instructions](https://docs.docker.com/compose/install/) to upgrade your version of docker-compose if needed. At the time of writing, the current docker-compose version was `1.29.2`.

## Run Koinos

Once docker-compose is installed, run `docker-compose up` to start a Koinos node.

By default, each container will use `~/.koinos` on the host as their base directory. This can be changed by setting `BASEDIR` in `.env`, or exporting `BASEDIR`, to a different location on the host machine.

You will find `config.yml` in the base directory, which can be modified to change config on the microservices. At present, you need to restart docker compose for the new config to be applied. (That is a future TODO)

Different images can be run by setting environment variables or setting them in `.env`. For each microservice, append `_TAG` (e.g. `export P2P_TAG=64-auto-gossip`).

By default the node will only run core required microservices (chain, block_store, mempool, and p2p).

You can run optional microservices by enabling the associated docker compose profiles:

 - `block_producer` to enable the block production.
 - `jsonrpc` to enable JSON-RPC API handling.
 - `transaction_history` to enable transaction history tracking.

These profiles can be set with the `--profile` options (i.e. `docker-compose --profile api up `) or by setting the `COMPOSE_PROFILES` environment variable during invocation or in `.env`.

For more information on docker compose profiles, please read the official [documentation](https://docs.docker.com/compose/profiles/).
