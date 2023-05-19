# Running a Koinos node

The Koinos cluster is comprised of multiple microservices. To simplify the deployment of the Koinos cluster, it is recommended to use the provided Docker compose script to launch a local node. The most time consuming part would be installing Docker, after that its just a matter of cloning the repository and running a single command.

## Installing on macOS/Linux

1. Download and install [Docker](https://www.docker.com/products/docker-desktop)
2. Clone (or download) the Koinos repository from [github](http://github.com/koinos/koinos)
3. Copy `config-example` to `config` and `env.example` to `.env`
4. Open the terminal in the downloaded directory and run the following command:

```console
$ docker compose --profile all up
```

## Installing on Windows

1. Download and install Docker
2. Clone (or download) the Koinos repository from [github](http://github.com/koinos/koinos)
3. Copy `config-example` to `config` and `env.example` to `.env`
4. Edit the first line in the .env file to read:

```console
BASEDIR=c:\koinos
```

5. Open the terminal in the downloaded directory and run the following command:

```console
$ docker compose up
```

---

## Managing a node

Nodes can be configured through two mechanisms, environment variables that change which servies are running, and the node config.

By default, each container will use `~/.koinos` on the host as their base directory. This can be changed by setting `BASEDIR` in `.env`, or exporting `BASEDIR`, to a different location on the host machine.

Different images can be run by setting environment variables or setting them in `.env`. For each microservice, append `_TAG` (e.g. `export P2P_TAG=64-auto-gossip`).

By default the node will only run core required microservices (chain, block_store, mempool, and p2p).

You can run optional microservices by enabling the associated docker compose profiles:

 - `block_production` to enable the block production.
 - `jsonrpc` to enable JSON-RPC API handling.
 - `grpc` to enable gRPC API handling.
 - `transaction_store` to enable transaction history tracking.
 - `contract_meta_store` to enable service of contract ABIs.
 - `account_history` to enable account history tracking.
 - `api` to enable API related microservices (`jsonrpc`, `grpc`, `transaction_store`, `contract_meta_store`, and `account_history`).
 - `all` to enable all microservices.

These profiles can be set with the `--profile` options (i.e. `docker compose --profile jsonrpc up`) or by setting the `COMPOSE_PROFILES` environment variable during invocation or in `.env`.

For more information on docker compose profiles, please read the official [documentation](https://docs.docker.com/compose/profiles/).

Inside the `config` directory are four config files, `config.yml`, `genesis_data.json`, `koinos_descriptors.pb`, and `rabbitmq.conf`.

`config.yml` directly configures the Koinos microservices. Options in the global namespace apply to all microservices. Options under a specific microservice apply just to that microservice. Many options, such as `log`, are the same across all microservices to allow configuration in the global namespace as well as microservice specific overrides.

`genesis_data.json` is the initial genesis state of the blockchain (block 0). This sets important system variables such as the genesis public key to boot the blockchain. The hash of all the genesis data is called the Chain ID. The Chain ID is used to quickly differentiate between different blockchains. This file should never be changed.

`koinos_descriptors.pb` is an encoded representation of all Koinos Protocol Buffers definitions. It is used by the JSON RPC microservice to service API calls. This file should be updated with new versions but not manually editted.

`rabbitmq.conf` is the configuration file for the AMQP microservice. It can be modified, but is recommended only advanced users modify this file. For more information on configuring Rabbit MQ, please read the official [documentation](https://www.rabbitmq.com/configure.html#config-items).

# Microservice options

These options can be set in the `config.yml`. If an option is shared by multiple microservices (such as `log`), you can set it for all of them by specifying it under `global`. Any option set for an individual microservice will override the global setting. Using this behavior you could enable debug level logging for one microservice while keeping info logs for the rest.

## Chain

 - `help`: Print this help message and exit
 - `version`: Print version string and exit
 - `basedir`: Koinos base directory
 - `amqp`: AMQP server URL
 - `log-level`: The log filtering level
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: The number of worker jobs
 - `read-compute-bandwidth-limit`: The compute bandwidth when reading contracts via the API
 - `genesis-data`: The genesis data file
 - `statedir`: The location of the blockchain state files (absolute path or relative to basedir/chain)
 - `reset`: Reset the database
 - `fork-algorithm`: The fork resolution algorithm to use. Can be 'pob', 'fifo', or 'block-time'. (Default: 'pob')

## Mempool

 - `help`: Print this help message and exit
 - `version`: Print version string and exit
 - `basedir`: Koinos base directory
 - `amqp`: AMQP server URL
 - `log-level`: The log filtering level
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: The number of worker jobs
 - `transaction-expiration`: The number of seconds a transaction should expire in
 - `fork-algorithm`: The fork resolution algorithm to use. Can be 'fifo', 'pob', or 'block-time'. (Default: 'fifo')

## Block Store

 - `amqp`: AMQP server URL
 - `basedir`: Koinos base directory
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: Number of RPC jobs to run (default 32)
 - `log-level`: The log filtering level
 - `reset`: Reset the database
 - `version`: Print version and exit

## P2P

 - `amqp`: AMQP server URL
 - `basedir`: Koinos base directory
 - `checkpoint`: Block checkpoint in the form height:blockid (may specify multiple times)
 - `disable-gossip`: Disable gossip mode
 - `force-gossip`: Force gossip mode
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: Number of RPC jobs to run (default 32)
 - `listen`: The multiaddress on which the node will listen
 - `log-level`: The log filtering level
 - `peer`: Address of a peer to which to connect (may specify multiple)
 - `seed`: Seed string with which the node will generate an ID (A randomized seed will be generated if none is provided)
 - `version`: Print version and exit

## Block Producer

 - `help`: Print this help message and exit
 - `version`: Print version string and exit
 - `basedir`: Koinos base directory
 - `amqp`: AMQP server URL
 - `log-level`: The log filtering level
 - `instance-id`: An ID that uniquely identifies the instance
 - `algorithm`: The consensus algorithm to use
 - `jobs`: The number of worker jobs
 - `work-groups`: The number of worker groups
 - `private-key-file`: The private key file
 - `pow-contract-id`: The PoW contract ID
 - `pob-contract-id`: The PoB contract ID
 - `vhp-contract-id`: The VHP contract ID
 - `max-inclusion-attempts`: The maximum transaction inclusion attempts per block
 - `resources-lower-bound`: The lower bound of resource utilization a newly created block will be considered adequate for submission
 - `resources-upper-bound`: The upper bound of resource utilization a newly created block should not exceed
 - `gossip-production`: Use p2p gossip status to determine block production
 - `producer`: The beneficiary address used during PoB production
 - `approve-proposals`: A list a proposal to approve when producing a block

## Transaction Store

 - `amqp`: AMQP server URL
 - `basedir`: Koinos base directory
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: Number of RPC jobs to run (default 32)
 - `log-level`: The log filtering level
 - `reset`: Reset the database
 - `version`: Print version and exit

## JSON-RPC

 - `amqp`: AMQP server URL
 - `basedir`: Koinos base directory
 - `blacklist`: RPC targets to blacklist
 - `descriptors`: The directory containing protobuf descriptors for rpc message types
 - `endpoint`: HTTP listen endpoint
 - `gateway-timeout`: The timeout to enqueue a request (default 3)
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: Number of jobs (default 16)
 - `listen`: Multiaddr to listen on
 - `log-level`: The log filtering level
 - `mq-timeout`: The timeout for MQ requests (default 5)
 - `version`: Print version and exit
 - `whitelist`: RPC targets to whitelist

## gRPC

 - `basedir`: Koinos base directory
 - `amqp`: AMQP server URL
 - `log-level`: The log filtering level
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: The number of worker jobs
 - `mq-timeout`: The timeout for MQ requests
 - `endpoint`: The endpoint the server listens on
 - `whitelist`: RPC targets to whitelist
 - `blacklist`: RPC targets to blacklist

## Contract Meta Store

 - `amqp`: AMQP server URL
 - `basedir`: Koinos base directory
 - `instance-id`: An ID that uniquely identifies the instance
 - `jobs`: Number of RPC jobs to run (default 32)
 - `log-level`: The log filtering level
 - `reset`: Reset the database
 - `version`: Print version and exit

## Account History

 - `help`: Print this help message and exit
 - `version`: Print version string and exit
 - `basedir`: Koinos base directory
 - `amqp`: AMQP server URL
 - `log-level`: The log filtering level
 - `instance-id`: And ID that uniquely identifies the instance
 - `jobs`: The number of worker jobs
 - `statedir`: The location of the blockchain state files (absolute path or relative to basedir/chain)
 - `reset`: Reset the database
 - `fork-algorithm`: The fork resolution algorithm to use. Can be 'fifo', 'pob', or 'block-time'. (Default: 'fifo')
