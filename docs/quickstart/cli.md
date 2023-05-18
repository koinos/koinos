# Using the Koinos CLI

The Koinos Command Line Interface (CLI) is a comprehensive command line tool for interacting with the Koinos Blockchain.

## Installing and starting the CLI

The latest release can be downloaded from [GitHub](https://github.com/koinos/koinos-cli).

Start the CLI with the binary included in the archive.

## Basic usage

When running the wallet, it will start in interactive mode. Press tab or type `list` to see a list of possible commands.

`help <command-name>` will show a help message for the given command.

Some commands require a node RPC endpoint. This can be specified either when starting the CLI with `--rpc` command line switch, or with the `connect` command from within the CLI. Both take an endpoint url.

Here is an example of launching from the command line with an RPC:

```console
$ koinos-cli --rpc https://api.koinos.io/
```

And here is an example of the connect command:
```
🚫 🔐 > connect https://api.koinos.io/
Connected to endpoint https://api.koinos.io/
```

There is a public RPC server that may be used for testing at this address: `https://api.koinos.io/`

If there is a red symbol to the left of the prompt, it indicates that you are not connected to an RPC endpoint.

`exit` or `quit` will quit the wallet.

## Wallet creation & management

The lock symbol to the left of the prompt indicates whether or not you have a wallet open. Some commands require an open wallet.

To create a new wallet, use the command `create <filename> <password>`. The new wallet will then be created in the given file, and automatically opened.

Example:
```
🔐 > create my.wallet password1234
Created and opened new wallet: my.wallet
Address: 1Nj4VvJhJBurG5XrQHixSB4K5WZbQM1GTW
```

To open a previously created wallet, use the command `open <filename> <password>`.

Example:
```
🔐 > open my.wallet password1234
Opened wallet: my.wallet
```

To import an existing Wallet Import Format (WIF) private key, use the commands `import <wif> <filename> <password>`.

Example:
```
🔓 > import 5KPJcpkw7GBtxjNrzroYgVwjR8CnTwbPrybuwfb8ff1Hw4GcqB5 imported.wallet password1234
Created and opened new wallet: imported.wallet
Address: 15XjYr9DkyrxaY2mgjRiRLpYww8cHquW4U
```

To close the open wallet, simply use the `close` command.

Any of the commands which take a password may be called with it omitted. In this case it will use the value in the `WALLET_PASS` environment variable / .env file.

## Other useful commands

To check the balance of a given public address, use the command `balance <address>`.

To transfer tKOIN from the currently open wallet, use the command `transfer <amount> <address>`.

## Smart contract management

> _**Note:** Smart contract management will change in the future to be much easier to work with._

To upload a smart contract, use the command `upload <filename>`. The file given should be a compiled wasm smart contract. The contract id will be the public address of the currently open wallet.

Example:
```
🔓 > upload token.wasm
Contract uploaded with address 15XjYr9DkyrxaY2mgjRiRLpYww8cHquW4U
Submitted transaction with ID 0x12202687e8f3ccf8175e7b63a24862ee15b5481ce484ee128eeccba60b68ec69d2ae
```

To interact with a smart contract, first register its ABI file with the command `register <name> <address> abi-filename>` using the contract's address and a name of your choosing.

Example:
```
🔓 > register koin 15im92XgZiV39tcKMhMGtDYhJjXPMjUu8r abi/koin.abi
Contract 'koin' at address 15im92XgZiV39tcKMhMGtDYhJjXPMjUu8r registered
```

Its methods will then be added to the list of available commands in the CLI.

Example:

```
🔓 > list
...
koin.balance_of   - Checks the balance at an address
koin.decimals     - Return the token's decimal precision
koin.mint         - Mints the token
koin.name         - Returns the token's name
koin.symbol       - Returns the token's symbol
koin.total_supply - Mints the token's total supply
koin.transfer     - Transfers the token
...

🔓 > help koin.balance_of
Checks the balance at an address
Usage: koin.balance_of <owner:address>

🔓 > koin.balance_of 1H7NoCkYiVciGLGA92LyAR2VvFLNN38qyM
value:31870000000000

🔓 > help koin.transfer
Transfers the token
Usage: koin.transfer <from:address> <to:address> <value:uint>

🔓 > koin.transfer 1H7NoCkYiVciGLGA92LyAR2VvFLNN38qyM 13daTg586CnrVjKRjGwBtBWH6eda99A7bw 100000000
Calling koin.transfer with arguments 'from:"1H7NoCkYiVciGLGA92LyAR2VvFLNN38qyM"  to:"13daTg586CnrVjKRjGwBtBWH6eda99A7bw"  value:100000000'
Submitted transaction with id 1220efc02549b2c1e24b685b2f3193f05bbc4197dc44984ead6409555fad3f338fa8

🔓 > koin.balance_of 13daTg586CnrVjKRjGwBtBWH6eda99A7bw
value:100000000
```

## Transaction sessions

Sometimes it is important to ensure multiple operations are included in the same block in a specific order. To accomplish this with the CLI, you use a session.

To begin a session, use the command `session begin`. A paper icon will appear to the left of the prompt while a session is active.

Any command that interacts with the chain will now be added to the current session.

To view the current session, use `session view`.

To cancel the current session, use `session cancel`.

When you are done adding commands to the session, `session submit` will send the attached commands as a single transaction to the blockchain.

Example:
```
🔓 > session begin
Began transaction session

🔓 📄 > transfer 1.0 1BLUi4ogqptnyBnSuKFyWMxEyVJzxiZWhM
Transferring 1 tKOIN to 1BLUi4ogqptnyBnSuKFyWMxEyVJzxiZWhM
Adding operation to transaction session

🔓 📄 > upload token.wasm
Contract uploaded with address 15XjYr9DkyrxaY2mgjRiRLpYww8cHquW4U
Submitted transaction with ID 0x12202687e8f3ccf8175e7b63a24862ee15b5481ce484ee128eeccba60b68ec69d2ae

🔓 📄 > transfer 25.0 15Pb7o5GFBB56njFNvU2fAfa9Mm7rmsJH1
Transferring 25 tKOIN to 15Pb7o5GFBB56njFNvU2fAfa9Mm7rmsJH1
Adding operation to transaction session

🔓 📄 > session view
Transaction Session (2 operations):
0: Transfer 1 tKOIN to 1BLUi4ogqptnyBnSuKFyWMxEyVJzxiZWhM
1: Upload contract with address 15XjYr9DkyrxaY2mgjRiRLpYww8cHquW4U
2: Transfer 25 tKOIN to 15Pb7o5GFBB56njFNvU2fAfa9Mm7rmsJH1

🔓 📄 > session submit
Submitted transaction with ID 0x12202a7e68e58223a143106cb293e44c491132c4c6b075b9cc6657ededc7ebd142b2 (3 operations)
```

## Non-interactive mode

Commands can be executed without using interactive mode. The `--execute` command-line parameter takes a semicolon separated list of commands, executes them, then returns to the terminal.
