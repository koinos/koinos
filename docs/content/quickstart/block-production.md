# Block production

Koinos uses the novel consensus algorithm, Proof-of-Burn (PoB). To participate in block production you will need to configure your node as well as perform some simple actions on the blockchain.

## Proof-of-Burn basics

Proof-of-Burn has similarities to both Proof-of-Work (PoW) and Proof-of-Stake (PoS) with some notable differences. Like Proof-of-Stake, no mining occurs to produce blocks; this places all physical nodes on an equal playing field. Hashing is simulated in Proof-of-Burn by burning KOIN in order to gain Virtual Hash Power (VHP). Aside from using VHP rather than physical machines performing hashes, the algorithm works similarly to Proof-of-Work.

## Prerequisites

Please follow our guide on [running a node](../index.md). Be sure to start the node with the `--profile all` or `--profile block_producer` option to start the optional block producer microservice.

## Retrieving your address and key

Upon starting a new node, a private block production key will be automatically generated for you. This key will be at `$KOINOS_BASEDIR/block_producer/private.key` (`$KOINOS_BASEDIR` is `~/.koinos` on macOS/Linux and `C:\koinos` for Windows if following our guide). There is a corresponding `public.key` file that is written out when the block producer runs and is always the public key corresponding to the private key that the block producer is configured to use (`private.key` by default).

You will want to copy the contents of `public.key` and save this for later use. This is our "hot" key.

```console
cat $KOINOS_BASEDIR/block_producer/public.key
Aq4Ps_Ch-f8OZDnpQOov2SiMvdYyA5tn0oWa36QWnTeH
```

Next, you will want your main account to hold VHP and KOIN for block production. Let us use the `koinos-cli` to register the PoB contract and open the wallet for our main account.

```console
./koinos-cli -r http://localhost:8080/
🔐 > register pob 159myq5YUhhoVWu3wsHKHiJYKPKGUrGiyv
🔐 > open <wallet_file> <password>
```

Let us grab our main account address so that we can register it within the Proof-of-Burn contract.

```console
🔓 > address
Wallet address: 1P4msR22FXKHZragcLk2dCNweTEi9JWgxn
```

## Registering your key and burning

Using the address from our main account and the public key from our block producer we will now create the association in the Proof-of-Burn contract.

```console
🔓 > pob.register_public_key 1P4msR22FXKHZragcLk2dCNweTEi9JWgxn Aq4Ps_Ch-f8OZDnpQOov2SiMvdYyA5tn0oWa36QWnTeH
```

Next, we must burn some KOIN in order to receive VHP. Let us burn 10,000 KOIN in exchange for 10,000 VHP. The `pob.burn` call is requesting that 10,000 KOIN be burned from the first address and place 10,000 VHP in to the second address. In our case, we want the address to burn KOIN from to be the same that receives VHP.

```console
🔓 > pob.burn 1000000000000 1P4msR22FXKHZragcLk2dCNweTEi9JWgxn 1P4msR22FXKHZragcLk2dCNweTEi9JWgxn
```
> _**Note:** You may repeat this process to top off your VHP as you run your block producer over time. Do not burn your entire KOIN balance as you will need liquid KOIN and its associated mana in order to produce blocks._

## Configuring the block producer

At this point, the chain has all the information required in order for us to produce blocks. Let us update our block producer configuration file to reflect the information we provided the chain. We should uncomment or add the `producer` line to let the block producer know which account holds our VHP. Below is an example configuration using the address and key from this guide.

```yml
block_producer:
  algorithm: pob
  pob-contract-id: 159myq5YUhhoVWu3wsHKHiJYKPKGUrGiyv
  vhp-contract-id: 1AdzuXSpC6K9qtXdCBgD5NUpDNwHjMgrc9
  producer: 1P4msR22FXKHZragcLk2dCNweTEi9JWgxn
```

## Producing blocks

Now that our configuration file is prepared we may restart our block producer in order to use the new settings. From the directory containing your `docker-compose.yml` execute:

```console
docker compose restart block_producer
```

If everything is working as expected your block production logs should look like this:

```console
koinos-block_producer-1       | 2022-08-18 17:56:08.489496 (block_producer.Koinos) [block_producer.cpp:296] <info>: Produced block - Height: 220753, ID: 0x1220003c080793c08de2bb3a7d94986b85cbe4f0c8c3c9ad3b6dd036379bc048f421
koinos-block_producer-1       | 2022-08-18 17:56:08.495517 (block_producer.Koinos) [block_producer.cpp:219] <info>: Created block containing 0 transactions utilizing approximately 0/204800 disk, 0/1048576 network, 0/287500000 compute
koinos-block_producer-1       | 2022-08-18 17:56:08.501338 (block_producer.Koinos) [pob_producer.cpp:347] <info>: Difficulty target: 0x00000000000002c7bf812846eacfa2a3
koinos-block_producer-1       | 2022-08-18 17:56:08.502196 (block_producer.Koinos) [pob_producer.cpp:349] <info>: Estimated total VHP producing: 863917.30411773 VHP
koinos-block_producer-1       | 2022-08-18 17:56:08.502890 (block_producer.Koinos) [pob_producer.cpp:352] <info>: Producing with 10000.00000000 VHP
koinos-block_producer-1       | 2022-08-18 17:56:10.539163 (block_producer.Koinos) [pob_producer.cpp:98] <info>: Burn difficulty met at quantum 1660845375530
```

Congratulations, you are now producing blocks using Proof-of-Burn!
