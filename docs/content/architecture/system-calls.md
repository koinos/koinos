# System calls

System calls are how requests to the Koinos Blockchain Framework are made. Each system call provides important functionality to be utilized from smart contracts or other parts of the framework.

Each system call has its base functionality implemented natively in a function known as a "thunk". What differentiates a system call from its thunk, is that the system call can have its functionality overridden by a special type of smart contract known as a "system contract".

|System Call|Description|
|---|---|
|`get_head_info`|Retrieves the current head block information|
|`apply_block`|Applies a block to the blockchain|
|`apply_transaction`|Applies a transaction to the current block|
|`apply_upload_contract_operation`|Applies an upload contract operation to the current transaction|
|`apply_call_contract_operation`|Applies a call contract operation to the current transaction|
|`apply_set_system_call_operation`|Applies a set system call operation to the current transaction|
|`apply_set_system_contract_operation`|Applies a set system contract operation to the current transaction|
|`pre_block_callback`|Callback prior to block application|
|`post_block_callback`|Callback after block application|
|`pre_transaction_callback`|Callback prior to transaction application|
|`post_transaction_callback`|Callback after transaction application|
|`get_chain_id`|Retrieves the current chain ID|
|`process_block_signature`|Handles block signatures during block application|
|`get_transaction`|Retrieves the current transaction|
|`get_transaction_field`|Retrieves a field from the current transaction|
|`get_block`|Retrieves the current block|
|`get_block_field`|Retrieves a field from the current block|
|`get_last_irreversible_block`|Retrieves the last irreversible block height|
|`get_account_nonce`|Retrieves the last account nonce|
|`verify_account_nonce`|Verifies the account nonce|
|`set_account_nonce`|Sets an account nonce|
|`check_system_authority`|Verifies whether the system authorizes the action|
|`get_operation`|Retrieves the current operation|
|`get_account_rc`|Retrieves the current account resource credits|
|`consume_account_rc`|Consumes resource credits on an account|
|`get_resource_limits`|Retrieves the current resource limits|
|`consume_block_resources`|Consumes resource credits for the block|
|`put_object`|Inserts data into a key value store|
|`remove_object`|Deletes data in the key value store|
|`get_object`|Retrieves data from the key value store|
|`get_next_object`|Iterates forward through the key value store|
|`get_prev_object`|Iterates backwards through the key value store|
|`log`|Emits a log entry|
|`event`|Emits an event|
|`hash`|Performs a hashing algorithm on given data|
|`recover_public_key`|Recovers a public key|
|`verify_merkle_root`|Validates a merkle root given leaves|
|`verify_signature`|Validates a signature|
|`verify_vrf_proof`|Validate a verifiably random proof|
|`call`|Calls another smart contract|
|`exit`|Stops smart contract execution|
|`get_arguments`|Retrieves arguments passed to a smart contract|
|`get_contract_id`|Retrieves the current smart contract ID|
|`get_caller`|Retrieves the caller of the smart contract|
|`check_authority`|Validates authorization was given|
|`get_contract_name`|Retrieves the name of a smart contract given the address from the name service|
|`get_contract_address`|Retrieves the address of a smart contract given the name from the name service|

> _**Table 1.** A comprehensive list of system calls._

Detailed information regarding the arguments and return values of system calls are defined as protocol buffer messages in the [Koinos Proto](https://github.com/koinos/koinos-proto/blob/master/koinos/chain/system_calls.proto) repository.

## Overriding system calls

While any system call can be overridden by a contract that simply calls the underlying thunk, the underlying functionality of some of them cannot be reproduced in the VM. **Table 1** lists system calls which cannot be fully replaced by an override, and the reason it cannot be overridden.

> _**Table 2.** System calls which cannot be overridden_

|System Call|Reason|
|---|---|
|`apply_block`|Requires access to the execution context|
|`apply_set_system_call_operation`|Requires call to `get_transaction`|
|`apply_set_system_contract_operation`|Requires call to `get_transaction`|
|`apply_transaction`|Requires state access|
|`call`|Requires stack frame access|
|`event`|Requires event recorder access|
|`exit`|Would cause infinite recursion|
|`get_caller`|Requires stack frame access and caller access on execution environment|
|`get_arguments`|Requires access to contract call arguments on execution environment|
|`get_contract_id`|Requires access to contract id on execution environment|
|`get_head_info`|Requires state access|
|`get_last_irreversible_block`|Requires state access|
|`get_next_object`|Requires state access|
|`get_object`|Requires state access|
|`get_prev_object`|Requires state access|
|`put_object`|Requires state access|
