# Deploying a smart contract

This guide assumes you have already built a smart contract. If you have not done so, you can learn how in one of these guides ([Typescript First Smart Contract](AssemblyScript/typescript-first-smart-contract.md), [Deploying a Token](./deploying-token.md)).

Once you have your contract built, you will have two files. This guide will refer to them as `contract.wasm` and `contract.abi`. `contract.wasm` is the smart contract Web Assembly (WASM) binary and `contract.abi` is the Application Binary Interface (ABI). Strictly speaking, only the WASM binary is required, but it is highly recommended to make use of the ABI.

## Upload using the CLI

We will use the Koinos CLI to upload the smart contract. If you do not have the CLI, you can follow the [CLI Guide](../quickstart/cli.md) to learn how to install and use the CLI.

The CLI has an `upload` command for this purpose.

```
🔐 > help upload
Upload a smart contract
Usage: upload <filename:file> [abi-filename:file] [override-authorize-call-contract:bool] [override-authorize-transaction-application:bool] [override-authorize-upload-contract:bool]
```

Only the first argument (the WASM bytecode) is required. The other four arguments are all optional.

On Koinos, a contract is an address and vice versa. The importance of this will become apparent later. This is in stark contrast to other blockchains, such as Ethereum, where a contract upload generates a new address.

If you have not created a wallet in the CLI, you can use the `create` command.

```
🔐 > help create
Create and open a new wallet file
Usage: create <filename:file> [password:string]

🔐 > create my.wallet mypassword
Created and opened new wallet: my.wallet
Address: 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4
```

> _**Note:** When you have an open wallet the prompt will change to an open lock 🔓._

In this example, your contract would be uploaded to `1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4`, and other users will be able to call your contract at this address. For this reason, it is recommended to create a new address for your smart contract, rather than using an address you are already using. Remember, creating addresses is free.

If you are using an existing wallet, you can check your address with the `address` command.

```
🔓 > address
Wallet address: 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4
```

## The ABI

The second argument to upload a contract is the contract ABI. The ABI is metadata that describes how to interact with the smart contract. This includes all contract entry points (public smart contract functions), their parameter and return types, and the protobuf descriptor required for the serialization of public-facing types. The ABI is a JSON file. In order to use an ABI, you do not need to be familiar with the structure. The Assembly Script SDK generates the ABI automatically and the CLI and other libraries already know how to read it. But for the sake of completion, below is the ABI for the Proof of Burn contract.

``` json
{
   "methods" : {
      "burn": {
         "argument"    : "koinos.contracts.pob.burn_arguments",
         "return"      : "koinos.contracts.pob.burn_result",
         "entry-point" : "0x859facc5",
         "description" : "Burn KOIN to receive VHP",
         "read-only"   : false
      },
      "get_metadata": {
         "argument"    : "koinos.contracts.pob.get_metadata_arguments",
         "return"      : "koinos.contracts.pob.get_metadata_result",
         "entry-point" : "0xfcf7a68f",
         "description" : "Returns PoB metadata",
         "read-only"   : true
      },
      "get_consensus_parameters": {
         "argument"    : "koinos.contracts.pob.get_consensus_parameters_arguments",
         "return"      : "koinos.contracts.pob.get_consensus_parameters_result",
         "entry-point" : "0x5fd7ac0f",
         "description" : "Returns PoB consensus parameters",
         "read-only"   : true
      },
      "register_public_key": {
         "argument"    : "koinos.contracts.pob.register_public_key_arguments",
         "return"      : "koinos.contracts.pob.register_public_key_result",
         "entry-point" : "0x53192be1",
         "description" : "Registers a block production public key to an address",
         "read-only"   : false
      }
   },
   "types" : "CtULCh5rb2lub3MvY29udHJhY3RzL3BvYi9wb2IucHJvdG8SFGtvaW5vcy5jb250cmFjdHMucG9iGhRrb2lub3Mvb3B0aW9ucy5wcm90byLiAQoUY29uc2Vuc3VzX3BhcmFtZXRlcnMSPwocdGFyZ2V0X2FubnVhbF9pbmZsYXRpb25fcmF0ZRgBIAEoDVIZdGFyZ2V0QW5udWFsSW5mbGF0aW9uUmF0ZRIuChN0YXJnZXRfYnVybl9wZXJjZW50GAIgASgNUhF0YXJnZXRCdXJuUGVyY2VudBIyChV0YXJnZXRfYmxvY2tfaW50ZXJ2YWwYAyABKA1SE3RhcmdldEJsb2NrSW50ZXJ2YWwSJQoOcXVhbnR1bV9sZW5ndGgYBCABKA1SDXF1YW50dW1MZW5ndGgiOAoRcHVibGljX2tleV9yZWNvcmQSIwoKcHVibGljX2tleRgBIAEoDEIEgLUYAFIJcHVibGljS2V5InYKCG1ldGFkYXRhEhgKBHNlZWQYASABKAxCBIC1GABSBHNlZWQSJAoKZGlmZmljdWx0eRgCIAEoDEIEgLUYAFIKZGlmZmljdWx0eRIqCg9sYXN0X2Jsb2NrX3RpbWUYAyABKARCAjABUg1sYXN0QmxvY2tUaW1lIngKDnNpZ25hdHVyZV9kYXRhEiEKCXZyZl9wcm9vZhgBIAEoDEIEgLUYAFIIdnJmUHJvb2YSHwoIdnJmX2hhc2gYAiABKAxCBIC1GABSB3ZyZkhhc2gSIgoJc2lnbmF0dXJlGAMgASgMQgSAtRgAUglzaWduYXR1cmUiSgoLdnJmX3BheWxvYWQSGAoEc2VlZBgBIAEoDEIEgLUYAFIEc2VlZBIhCgpibG9ja190aW1lGAIgASgEQgIwAVIJYmxvY2tUaW1lImYKHXJlZ2lzdGVyX3B1YmxpY19rZXlfYXJndW1lbnRzEiAKCHByb2R1Y2VyGAEgASgMQgSAtRgGUghwcm9kdWNlchIjCgpwdWJsaWNfa2V5GAIgASgMQgSAtRgAUglwdWJsaWNLZXkiHAoacmVnaXN0ZXJfcHVibGljX2tleV9yZXN1bHQihwEKDmJ1cm5fYXJndW1lbnRzEiUKDHRva2VuX2Ftb3VudBgBIAEoBEICMAFSC3Rva2VuQW1vdW50EicKDGJ1cm5fYWRkcmVzcxgCIAEoDEIEgLUYBlILYnVybkFkZHJlc3MSJQoLdmhwX2FkZHJlc3MYAyABKAxCBIC1GAZSCnZocEFkZHJlc3MiDQoLYnVybl9yZXN1bHQiJAoiZ2V0X2NvbnNlbnN1c19wYXJhbWV0ZXJzX2FyZ3VtZW50cyJjCh9nZXRfY29uc2Vuc3VzX3BhcmFtZXRlcnNfcmVzdWx0EkAKBXZhbHVlGAEgASgLMioua29pbm9zLmNvbnRyYWN0cy5wb2IuY29uc2Vuc3VzX3BhcmFtZXRlcnNSBXZhbHVlIhgKFmdldF9tZXRhZGF0YV9hcmd1bWVudHMiSwoTZ2V0X21ldGFkYXRhX3Jlc3VsdBI0CgV2YWx1ZRgBIAEoCzIeLmtvaW5vcy5jb250cmFjdHMucG9iLm1ldGFkYXRhUgV2YWx1ZSJgChlyZWdpc3Rlcl9wdWJsaWNfa2V5X2V2ZW50EiMKCnB1YmxpY19rZXkYASABKAxCBIC1GABSCXB1YmxpY0tleRIeCgdhZGRyZXNzGAIgASgMQgSAtRgGUgdhZGRyZXNzIjwKGGdldF9wdWJsaWNfa2V5X2FyZ3VtZW50cxIgCghwcm9kdWNlchgBIAEoDEIEgLUYBlIIcHJvZHVjZXIiMwoVZ2V0X3B1YmxpY19rZXlfcmVzdWx0EhoKBXZhbHVlGAEgASgMQgSAtRgAUgV2YWx1ZUI8WjpnaXRodWIuY29tL2tvaW5vcy9rb2lub3MtcHJvdG8tZ29sYW5nL2tvaW5vcy9jb250cmFjdHMvcG9iYgZwcm90bzM="
}
```

In this ABI there are four entry points to the contract. Human readable descriptions are provided for developer convenience. In the CLI, this is used to generate the help functions. Some functions are labeled as read-only. This indicates that the function has no side effects and can be called outside of a transaction in a normal API call. Functions that are not read-only must be called from within a transaction, meaning they cost mana, can have side effects, are broadcast on the p2p network to all nodes, and are eventually included in a block. They should not be called indiscriminately.

The remaining, `types`, field is a Base64 encoded protobuf descriptor. It can be imported to most Protobuf runtime libraries to interact with reflected messages at runtime. Using these libraries, a smart contract can be interacted with without needing the language-specific generated protobuf files.

A smart contract can be uploaded with or without an ABI. If uploaded with an ABI, the ABI will be stored and retrievable through the Contract Meta Store microservice API. This is the simplest way to distribute your contract's ABI. The Koinos CLI and other tools automatically download the ABI of any contract they interact with.

There are reasons not to upload your ABI. While anyone can attempt to interact with your contract on the blockchain, not knowing the ABI makes it a black box. Keeping your ABI to yourself, or select partners, could be a way of gatekeeping access to your dAPP.

Keep in mind, changing the ABI or uploading an ABI on a contract that did not have one will require updating the contract bytecode as well. If you choose to lock yourself out of updating your smart contract through authorization overrides, you will not be able to update your ABI either.

## Authorize overrides

The three remaining fields of the smart contract are authorization overrides. Recall, in Koinos an address is a contract and a contract is an address. Any address can have a contract uploaded to it. By default, the private key corresponding to the address authorizes all transactions using that address. With authorization overrides, a smart contract can override that behavior for some, or all, types of authorizations. All Koinos system contracts utilize this system to defer their authorization to the Governance contract, ensuring that the individual contracts cannot be tampered with outside of a passed governance proposal.

There are three types of authorization overrides:

1. Call contract
2. Transaction application
3. Upload contract

The "call contract" authority is used when a contract is requesting the authorization of an address. This is by far the most common authority, being the only authority that a user contract can request. For example, if a token is requiring an address' authority before transferring that address' tokens, it will request the "call contract" authority.

The "transaction application" authority is used when an address is involved in a transaction. This covers both paying for a transaction (when the address is paying the mana for the transaction) and being the payee (when another address is paying for the transaction, but your address' nonce is being incremented). This authority can only be called by the system. This can be used to pay for other user's transactions. For example, if you have a dAPP and your own token, you can use ownership of your token to confer your mana rights to your users.

Lastly, the "upload contract" authority does exactly what it says. It is called when an address is attempting to upload a contract. Like "transaction application", it is also only called by the system. In Koinos, contracts can be re-uploaded as much as you want. Overriding this authority allows you to lock down your contract entirely, or implement your own form of decentralized governance for managing your contract.

## Calling your contract

Now that you have uploaded your contract using the CLI, you are going to want to interact with it. The CLI has two commands that allow you to do so, `register` and `register_token`.

```
🔓 > help register
Register a smart contract's commands
Usage: register <name:contract-name> <address:address> [abi-filename:file]

🔓 > help register_token
Register a token's commands
Usage: register_token <name:contract-name> <address:address> [symbol:string] [precision:string]
```

To register, you will need a contract name and an address. The name does not matter and is only used for generating commands in the CLI. Optionally, you can include an ABI you have locally. If you do not specify an ABI, the CLI will attempt to download it from the node you are connected to.

```
🔓 > register mycontract 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4
Contract 'mycontract' at address 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 registered
```

Once the contract is registered, you'll see the functions from the ABI added to the CLI.

```
🔓 > list
account_rc                                - Get the current resource credits for a given address (open wallet if blank)
address                                   - Show the currently opened wallet's address
call                                      - Call a smart contract
. . .
mycontract.function1                      - Description of function1
mycontract.function2                      - Description of function2
mycontract.function3                      - Description of function3
. . .
```

You can also use the help command on your contract commands:

```
🔓 > help mycontract.fucntion1
Description of function1
Usage: mycontract.function1 <arg1:argType>
```

Registering a contract with your own ABI works the exact same, except you pass the location of the ABI during registration.

```
🔓 > register mycontract 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 myabi.abi
Contract 'mycontract' at address 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 registered
```

Lastly, you can register the contract using the token standard. If your contract conforms to the token standard, you can register it as a token. This registers the contract with a more friendly interface. For example, the `balance_of` command requires passing an address. Using `register_token` `balance_of` will use the open wallet by default instead of requiring an address.

```
🔓 > register_token mytoken 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4
Token 'mytoken' at address 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 registered

🔓 > mytoken.balance_of
10.005 TKN
```

When registering a token, the symbol and precision is retrieved from the API node. You can override that if you wish. This is primarily useful when using the CLI offline.

```
🔓 > register_token mytoken 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 MYTKN 4
Token 'mytoken' at address 1Nro48sFcsFHidW4MvLpAiVqBiz1aCVqq4 registered

🔓 > mytoken.balance_of
1.0005 MYTKN
```
