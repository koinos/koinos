# Sending a transaction

We will use the Koinos CLI to send transactions. If you do not have the CLI, you can follow the [CLI Guide](../quickstart/cli.md) to learn how to install and use the CLI.

### Simple transactions

Most transactions contain a single operation, such as a token transfer. The CLI makes sending such a transaction easy. Simply execute the desired command and the transaction is automatically created, signed, and broadcast.

```
🔓 > koin.transfer 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc 1
Transferring 1 KOIN to 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc
Transaction with ID 0x1220c9bf8a71f0b8c7a9eb31a372685b3a9f3c82209c76c378f36f0b6cdbcca65f6d containing 1 operations submitted.
Mana cost: 0.1561714 (Disk: 112, Network: 312, Compute: 568587)
```

Upon sending a transaction, the transaction ID is displayed along with the total mana cost and the individual resources consumed. You can view your transaction via a block explorer (such as <a href=https://koinosblocks.com/ target="_blank">koinosblocks</a> or <a href=https://koiner.app/ target="_blank">Koiner</a>).

### Multi-op transactions

Sometimes you will need to perform multiple operations in a single transaction, such as transferring multiple tokens atomically. You can do this in the CLI using the transaction session feature. Using this feature, you can begin a new session and execute multiple commands, automatically adding them to the session, prior to sending the commands as a part of a single transaction.

> _**Note:** When you are working in a transaction session, the prompt will add a page 📄._

```
🔓 > session begin
Began transaction session

🔓 📄 > koin.transfer 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc 1
Transferring 1 KOIN to 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc
Adding operation to transaction session

🔓 📄 > koin.transfer 1KSwzR4MkDJfKz67GkYXtwmeRRzYYzZNst 1
Transferring 1 KOIN to 1KSwzR4MkDJfKz67GkYXtwmeRRzYYzZNst
Adding operation to transaction session

🔓 📄 > session view
Transaction Session (2 operations):
0: Transfer 1 KOIN to 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc
1: Transfer 1 KOIN to 1KSwzR4MkDJfKz67GkYXtwmeRRzYYzZNst

🔓 📄 > session submit
Transaction with ID 0x12206afb8536ee28fa64d00fc4beea1c1022c7029fa3d5e1ba25d92479b488cfcb02 containing 2 operations submitted.
Mana cost: 0.22073415 (Disk: 77, Network: 410, Compute: 918293)
```

You can also cancel your current transaction session using `session cancel`.

```
🔓 📄 > session cancel
Cancelled transaction session
```

### Offline transactions

Normally, the CLI will be connected to an API node. However, it has support for offline transaction signing. Please be aware that when operating the CLI in offline mode many features will not work, such as contract ABI retrieval. There may be other steps involved to interact with a more complicated contract in offline mode.

Additionally, to sign a transaction in offline mode, you will need to manually set your account nonce, rc limit, and chain id. Normally, those values are automatically retrieved and set by the CLI. When connected to an API node you can view the default nonce and rclimit values for a given address. If you are working with an offline wallet you will either need to track these values yourself, you use an external service/API to retrieve them.

```
🔓 > nonce
Nonce: auto (next nonce: 3)

🔓 > rclimit
Current rc limit: 10% (9.6764006)

🔓 > chain_id
Chain ID: auto (EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==)
```

You can set the nonce and rclimit using the same commands but with a desired value. You can disconnect from your current API node using the `disconnect` command.

> _**Note:** When the CLI is not connected to an API node, the prompt will add a 🚫._

```
🔓 > disconnect
Disconnected

🚫 🔓 > nonce 3
🚫 🔓 > nonce
Nonce: 3

🚫 🔓 > rclimit 9
Set rc limit to 9

🚫 🔓 > rclimit
Current rc limit: 9

🚫 🔓 > chain_id EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==
🚫 🔓 > chain_id
Chain ID: EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==
```

These values can be overridden when connected to an API node as well. The nonce and chain id can be reset using `auto` and the rclimit can be set to a percent value.

```
🔓 > nonce auto
🔓 > nonce
Nonce: auto (next nonce: 3)

🔓 > rclimit 25%
Set rc limit to 25%

🔓 > rclimit
Current rc limit: 25% (24.21006694)

🔓 > chain_id auto
🔓 > chain_id
Chain ID: auto (EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==)
```

Finally, to send a transaction offline, you must use a transaction session. The transaction session only needs to contain a single operation if desired, or multiple as needed. When creating a transaction in offline mode, instead of broadcasting the transaction, the CLI will log the transaction formatted in JSON and binary encoded in Base64.

```
🚫 🔓 > session begin
Began transaction session

🚫 🔓 📄 > koin.transfer 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc 1
Transferring 1 KOIN to 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc
Adding operation to transaction session

🚫 🔓 📄 > session submit
JSON:
{
  "id": "EiChh0s69uOvI2df8hHwlbugFdlaaqGZwDppxhw/atw1kQ==",
  "header": {
    "chain_id": "EiAAKqFi+puoXnuJTdn7qBGGJa8yd+dcS2P0ciODe4wupQ==",
    "rc_limit": 500000000,
    "nonce": "KAM=",
    "operation_merkle_root": "EiATHPNpk0YlOlg+/sp39eB0wwTinbuSFyJemnpxJD318A==",
    "payer": "AO/Fd7N60l7FD+quBEyDIS5B73Tez7tK0w=="
  },
  "operations": [
    {
      "Op": {
        "CallContract": {
          "contract_id": "AFseYdNyWbnC2Zv0F/WS4Ld3JRZdJIi+RQ==",
          "entry_point": 670398154,
          "args": "ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV+FWPPf//piXzGIDC1y8="
        }
      }
    }
  ],
  "signatures": [
    "H28oGtoudSD/bNPXydGGDJDSeRct/A2iPBcHgIssbN6WdggoYM5kRxs75bNEBGVBpC5F4SXNiOYk2Md6/v4efOc="
  ]
}

Base64:
CiISIKGHSzr2468jZ1_yEfCVu6AV2VpqoZnAOmnGHD9q3DWREm0KIhIgACqhYvqbqF57iU3Z-6gRhiWvMnfnXEtj9HIjg3uMLqUQgMq17gEaAigDIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR9vKBraLnUg_2zT18nRhgyQ0nkXLfwNojwXB4CLLGzelnYIKGDOZEcbO-WzRARlQaQuReElzYjmJNjHev7-Hnzn
```

You can use the JSON to broadcast the transaction yourself via the API, but the CLI can do this for you using the `submit_transaction` command. On a CLI connected to an API node, you can call `submit_transaction` along with the Base64 encoded transaction. Upon submission of the transaction, you will see the transaction ID, mana, and resource consumption log that you would have seen normally.

```
🔓 > submit_transaction CiISIKGHSzr2468jZ1_yEfCVu6AV2VpqoZnAOmnGHD9q3DWREm0KIhIgACqhYvqbqF57iU3Z-6gRhiWvMnfnXEtj9HIjg3uMLqUQgMq17gEaAigDIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR9vKBraLnUg_2zT18nRhgyQ0nkXLfwNojwXB4CLLGzelnYIKGDOZEcbO-WzRARlQaQuReElzYjmJNjHev7-Hnzn
Transaction with ID 0x1220a1874b3af6e3af23675ff211f095bba015d95a6aa199c03a69c61c3f6adc3591 containing 1 operations submitted.
Mana cost: 0.1281171 (Disk: 2, Network: 312, Compute: 574973)
```

### Multi-sig Transactions

The CLI also supports multi-sig transactions. The most common use case is having another address pay for your transaction. However, more complex smart contracts may require multi-sig transactions as well. Usually, the address performing an action on the Koinos blockchain (e.g. transferring a token) is also the address paying the mana for the transaction. However, that does not have to be the case.

A transaction can explicitly set a payer separate from the payee. In that case, the payer will pay the mana for the transaction, but the nonce of the payee will still be used. This can all be done in the CLI using the `payer` command. By default, the opened wallet is both the payer and payee. Multi-sig requires passing around a Base64 encoded transaction. Because of this, you must use offline signing. However, if you do not care about keeping your wallet offline, you can use the built-in `nonce`, `rclimit`, and `chain_id` commands to easily fill out those values prior to disconnecting from your API node. When creating a transaction offline, the current open wallet will automatically be the payee if a payer is set.

> _**Note:** Because another address is paying for the transaction, you will need to set rclimit based on their mana, not yours._

```
🔓 > nonce
Nonce: auto (next nonce: 4)

🔓 > nonce 4
🔓 > chain_id
Chain ID: auto (EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==)

🔓 > chain_id EiAAKqFi-puoXnuJTdn7qBGGJa8yd-dcS2P0ciODe4wupQ==
🔓 > rclimit
Current rc limit: 10% (9.6)

🔓 > rclimit 1
Set rc limit to 1

🔓 > payer 14naVKZmK1EMp5Kg3g3JScZesVQJp58sxK
🔓 > disconnect
Disconnected

🚫 🔓 > session begin
Began transaction session

🚫 🔓 📄 > koin.transfer 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc 1
Transferring 1 KOIN to 18EsxquZkwnsU2BEuPxtRpVabsvwsvhgjc
Adding operation to transaction session

🚫 🔓 📄 > session submit
JSON:
{
  "id": "EiCC9wVkaVkuuHgyjYBP6vlrJ9bYWaG79KaSTyz8qCUMoA==",
  "header": {
    "chain_id": "EiAAKqFi+puoXnuJTdn7qBGGJa8yd+dcS2P0ciODe4wupQ==",
    "rc_limit": 100000000,
    "nonce": "KAQ=",
    "operation_merkle_root": "EiATHPNpk0YlOlg+/sp39eB0wwTinbuSFyJemnpxJD318A==",
    "payer": "ACmHDNxlSHrPZhrHSs3Tk9aWbOiSkfgRCA==",
    "payee": "AO/Fd7N60l7FD+quBEyDIS5B73Tez7tK0w=="
  },
  "operations": [
    {
      "Op": {
        "CallContract": {
          "contract_id": "AFseYdNyWbnC2Zv0F/WS4Ld3JRZdJIi+RQ==",
          "entry_point": 670398154,
          "args": "ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV+FWPPf//piXzGIDC1y8="
        }
      }
    }
  ],
  "signatures": [
    "H7J49uO865WHB5gkieg7CRqZWFPu0Ksal5K85MN+ri8wHUNAAfbeMTGo901Eo1ewXuF3kRoc5GQ/ef2eGRGohos="
  ]
}

Base64:
CiISIIL3BWRpWS64eDKNgE_q-Wsn1thZobv0ppJPLPyoJQygEocBCiISIAAqoWL6m6hee4lN2fuoEYYlrzJ351xLY_RyI4N7jC6lEIDC1y8aAigEIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkAKYcM3GVIes9mGsdKzdOT1pZs6JKR-BEIMhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR-yePbjvOuVhweYJInoOwkamVhT7tCrGpeSvOTDfq4vMB1DQAH23jExqPdNRKNXsF7hd5EaHORkP3n9nhkRqIaL
```

Once you have the Base64 encoded transaction, either open the other wallet or send the Base64 transaction to whoever controls the other wallet. They can add their signature to the transaction using the `sign_transaction` command. Whatever wallet is open when the command is executed will sign the transaction. **Be sure you trust the transaction you are signing.**

Sign transaction will output a JSON and Base64 encoded transaction similar to an offline submission. That is because multi-sig transactions may require more than two signatures and broadcasting a multi-sig transaction should only happen once all required signatures are present.

```
🔓 > sign_transaction CiISIIL3BWRpWS64eDKNgE_q-Wsn1thZobv0ppJPLPyoJQygEocBCiISIAAqoWL6m6hee4lN2fuoEYYlrzJ351xLY_RyI4N7jC6lEIDC1y8aAigEIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkAKYcM3GVIes9mGsdKzdOT1pZs6JKR-BEIMhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR-yePbjvOuVhweYJInoOwkamVhT7tCrGpeSvOTDfq4vMB1DQAH23jExqPdNRKNXsF7hd5EaHORkP3n9nhkRqIaL
Signed Transaction:
JSON:
{
  "id": "EiCC9wVkaVkuuHgyjYBP6vlrJ9bYWaG79KaSTyz8qCUMoA==",
  "header": {
    "chain_id": "EiAAKqFi+puoXnuJTdn7qBGGJa8yd+dcS2P0ciODe4wupQ==",
    "rc_limit": 100000000,
    "nonce": "KAQ=",
    "operation_merkle_root": "EiATHPNpk0YlOlg+/sp39eB0wwTinbuSFyJemnpxJD318A==",
    "payer": "ACmHDNxlSHrPZhrHSs3Tk9aWbOiSkfgRCA==",
    "payee": "AO/Fd7N60l7FD+quBEyDIS5B73Tez7tK0w=="
  },
  "operations": [
    {
      "Op": {
        "CallContract": {
          "contract_id": "AFseYdNyWbnC2Zv0F/WS4Ld3JRZdJIi+RQ==",
          "entry_point": 670398154,
          "args": "ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV+FWPPf//piXzGIDC1y8="
        }
      }
    }
  ],
  "signatures": [
    "H7J49uO865WHB5gkieg7CRqZWFPu0Ksal5K85MN+ri8wHUNAAfbeMTGo901Eo1ewXuF3kRoc5GQ/ef2eGRGohos=",
    "IB2cPypEqZOP4qNslxoITOj5U0h5kGKH+b91VibED0QbUgh5II+ou994gOC0QC/yh93v0C4p3aYohweLcEPMsMk="
  ]
}
Base64:
CiISIIL3BWRpWS64eDKNgE_q-Wsn1thZobv0ppJPLPyoJQygEocBCiISIAAqoWL6m6hee4lN2fuoEYYlrzJ351xLY_RyI4N7jC6lEIDC1y8aAigEIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkAKYcM3GVIes9mGsdKzdOT1pZs6JKR-BEIMhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR-yePbjvOuVhweYJInoOwkamVhT7tCrGpeSvOTDfq4vMB1DQAH23jExqPdNRKNXsF7hd5EaHORkP3n9nhkRqIaLIkEgHZw_KkSpk4_io2yXGghM6PlTSHmQYof5v3VWJsQPRBtSCHkgj6i733iA4LRAL_KH3e_QLindpiiHB4twQ8ywyQ==
```

As you can see in the JSON transaction, there are now two signatures.

Just like the offline transaction, you can submit the transaction using `submit_transaction` when connected to an API node, being sure to copy the updated Base64 encoded transaction.

```
🔓 > submit_transaction CiISIIL3BWRpWS64eDKNgE_q-Wsn1thZobv0ppJPLPyoJQygEocBCiISIAAqoWL6m6hee4lN2fuoEYYlrzJ351xLY_RyI4N7jC6lEIDC1y8aAigEIiISIBMc82mTRiU6WD7-ynf14HTDBOKdu5IXIl6aenEkPfXwKhkAKYcM3GVIes9mGsdKzdOT1pZs6JKR-BEIMhkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTGmASXgoZAFseYdNyWbnC2Zv0F_WS4Ld3JRZdJIi-RRDK7dW_Aho7ChkA78V3s3rSXsUP6q4ETIMhLkHvdN7Pu0rTEhkAT2jUYPUH2cRWUQ8vWHLV-FWPPf__piXzGIDC1y8iQR-yePbjvOuVhweYJInoOwkamVhT7tCrGpeSvOTDfq4vMB1DQAH23jExqPdNRKNXsF7hd5EaHORkP3n9nhkRqIaLIkEgHZw_KkSpk4_io2yXGghM6PlTSHmQYof5v3VWJsQPRBtSCHkgj6i733iA4LRAL_KH3e_QLindpiiHB4twQ8ywyQ==
Transaction with ID 0x122082f7056469592eb878328d804feaf96b27d6d859a1bbf4a6924f2cfca8250ca0 containing 1 operations submitted.
Mana cost: 0.1460387 (Disk: 0, Network: 406, Compute: 648283)
```
