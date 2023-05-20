# Using the faucet on Discord

_**tKOIN**_ is the Koinos blockchain testnet token symbol.

Anyone can participate in the Koinos test network by [running a node](../index.md). By installing and running the node each user is assigned a public and private key. Using the key a user can receive _**tKOIN**_ from our discord faucet using the instructions below. The private key resides in `~/.koinos/block_producer/private.key` in macOS/Linux and `C:\.koinos` in Windows

After starting the node for the first time you can get your public key by looking at the `000.log` file in the `.koinos/block_producer` directory. It should be on the first line with the label "**Public address:**" unless the log file was rotated out. Alternatively, you can take the private key from `.koinos/block_producer/private.key` and import it into Koinos CLI to utilize the account and/or view the public address.

```console
$ head ~/.koinos/block_producer/000.log | grep "Public address"
```

It is also displayed when you first start the node although it usually scrolls out of view very quickly.


Once you have your public address you can join our [Discord](https://discord.com/invite/GErGNsu) server and request some _**tKOIN**_ in the `#faucet` channel by sending the following message to the faucet bot:

```
!faucet <public address>
```

Example:

```
!faucet 1ENxxuH81kytBdYe81fD9tBdYe81fD9Qxe
```

You can get your balance at any time using the command:

```
!balance <public address>
```

Example:

```
!balance 1ENxxuH81kytBdYe81fD9BdYe81fD9Qxe
```
