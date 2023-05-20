# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [koinos/rpc/contract_meta_store/contract_meta_store_rpc.proto](#koinos_rpc_contract_meta_store_contract_meta_store_rpc-proto)
    - [contract_meta_store_request](#koinos-rpc-contract_meta_store-contract_meta_store_request)
    - [contract_meta_store_response](#koinos-rpc-contract_meta_store-contract_meta_store_response)
    - [get_contract_meta_request](#koinos-rpc-contract_meta_store-get_contract_meta_request)
    - [get_contract_meta_response](#koinos-rpc-contract_meta_store-get_contract_meta_response)
  
- [koinos/rpc/rpc.proto](#koinos_rpc_rpc-proto)
    - [error_response](#koinos-rpc-error_response)
    - [reserved_rpc](#koinos-rpc-reserved_rpc)
  
- [koinos/rpc/transaction_store/transaction_store_rpc.proto](#koinos_rpc_transaction_store_transaction_store_rpc-proto)
    - [get_transactions_by_id_request](#koinos-rpc-transaction_store-get_transactions_by_id_request)
    - [get_transactions_by_id_response](#koinos-rpc-transaction_store-get_transactions_by_id_response)
    - [transaction_store_request](#koinos-rpc-transaction_store-transaction_store_request)
    - [transaction_store_response](#koinos-rpc-transaction_store-transaction_store_response)
  
- [koinos/rpc/chain/chain_rpc.proto](#koinos_rpc_chain_chain_rpc-proto)
    - [chain_request](#koinos-rpc-chain-chain_request)
    - [chain_response](#koinos-rpc-chain-chain_response)
    - [get_account_nonce_request](#koinos-rpc-chain-get_account_nonce_request)
    - [get_account_nonce_response](#koinos-rpc-chain-get_account_nonce_response)
    - [get_account_rc_request](#koinos-rpc-chain-get_account_rc_request)
    - [get_account_rc_response](#koinos-rpc-chain-get_account_rc_response)
    - [get_chain_id_request](#koinos-rpc-chain-get_chain_id_request)
    - [get_chain_id_response](#koinos-rpc-chain-get_chain_id_response)
    - [get_fork_heads_request](#koinos-rpc-chain-get_fork_heads_request)
    - [get_fork_heads_response](#koinos-rpc-chain-get_fork_heads_response)
    - [get_head_info_request](#koinos-rpc-chain-get_head_info_request)
    - [get_head_info_response](#koinos-rpc-chain-get_head_info_response)
    - [get_resource_limits_request](#koinos-rpc-chain-get_resource_limits_request)
    - [get_resource_limits_response](#koinos-rpc-chain-get_resource_limits_response)
    - [read_contract_request](#koinos-rpc-chain-read_contract_request)
    - [read_contract_response](#koinos-rpc-chain-read_contract_response)
    - [submit_block_request](#koinos-rpc-chain-submit_block_request)
    - [submit_block_response](#koinos-rpc-chain-submit_block_response)
    - [submit_transaction_request](#koinos-rpc-chain-submit_transaction_request)
    - [submit_transaction_response](#koinos-rpc-chain-submit_transaction_response)
  
- [koinos/rpc/block_store/block_store_rpc.proto](#koinos_rpc_block_store_block_store_rpc-proto)
    - [add_block_request](#koinos-rpc-block_store-add_block_request)
    - [add_block_response](#koinos-rpc-block_store-add_block_response)
    - [block_store_request](#koinos-rpc-block_store-block_store_request)
    - [block_store_response](#koinos-rpc-block_store-block_store_response)
    - [get_blocks_by_height_request](#koinos-rpc-block_store-get_blocks_by_height_request)
    - [get_blocks_by_height_response](#koinos-rpc-block_store-get_blocks_by_height_response)
    - [get_blocks_by_id_request](#koinos-rpc-block_store-get_blocks_by_id_request)
    - [get_blocks_by_id_response](#koinos-rpc-block_store-get_blocks_by_id_response)
    - [get_highest_block_request](#koinos-rpc-block_store-get_highest_block_request)
    - [get_highest_block_response](#koinos-rpc-block_store-get_highest_block_response)
  
- [koinos/rpc/p2p/p2p_rpc.proto](#koinos_rpc_p2p_p2p_rpc-proto)
    - [get_gossip_status_request](#koinos-rpc-p2p-get_gossip_status_request)
    - [get_gossip_status_response](#koinos-rpc-p2p-get_gossip_status_response)
    - [p2p_request](#koinos-rpc-p2p-p2p_request)
    - [p2p_response](#koinos-rpc-p2p-p2p_response)
  
- [koinos/rpc/mempool/mempool_rpc.proto](#koinos_rpc_mempool_mempool_rpc-proto)
    - [check_pending_account_resources_request](#koinos-rpc-mempool-check_pending_account_resources_request)
    - [check_pending_account_resources_response](#koinos-rpc-mempool-check_pending_account_resources_response)
    - [get_pending_transactions_request](#koinos-rpc-mempool-get_pending_transactions_request)
    - [get_pending_transactions_response](#koinos-rpc-mempool-get_pending_transactions_response)
    - [mempool_request](#koinos-rpc-mempool-mempool_request)
    - [mempool_response](#koinos-rpc-mempool-mempool_response)
    - [pending_transaction](#koinos-rpc-mempool-pending_transaction)
  
- [Scalar Value Types](#scalar-value-types)



<a name="koinos_rpc_contract_meta_store_contract_meta_store_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/contract_meta_store/contract_meta_store_rpc.proto



<a name="koinos-rpc-contract_meta_store-contract_meta_store_request"></a>

### contract_meta_store_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| get_contract_meta | [get_contract_meta_request](#koinos-rpc-contract_meta_store-get_contract_meta_request) |  |  |






<a name="koinos-rpc-contract_meta_store-contract_meta_store_response"></a>

### contract_meta_store_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| get_contract_meta | [get_contract_meta_response](#koinos-rpc-contract_meta_store-get_contract_meta_response) |  |  |






<a name="koinos-rpc-contract_meta_store-get_contract_meta_request"></a>

### get_contract_meta_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| contract_id | [bytes](#bytes) |  |  |






<a name="koinos-rpc-contract_meta_store-get_contract_meta_response"></a>

### get_contract_meta_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| meta | [koinos.contract_meta_store.contract_meta_item](#koinos-contract_meta_store-contract_meta_item) |  |  |





 

 

 

 



<a name="koinos_rpc_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/rpc.proto



<a name="koinos-rpc-error_response"></a>

### error_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| message | [string](#string) |  |  |
| data | [string](#string) |  |  |






<a name="koinos-rpc-reserved_rpc"></a>

### reserved_rpc






 

 

 

 



<a name="koinos_rpc_transaction_store_transaction_store_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/transaction_store/transaction_store_rpc.proto



<a name="koinos-rpc-transaction_store-get_transactions_by_id_request"></a>

### get_transactions_by_id_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction_ids | [bytes](#bytes) | repeated |  |






<a name="koinos-rpc-transaction_store-get_transactions_by_id_response"></a>

### get_transactions_by_id_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transactions | [koinos.transaction_store.transaction_item](#koinos-transaction_store-transaction_item) | repeated |  |






<a name="koinos-rpc-transaction_store-transaction_store_request"></a>

### transaction_store_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| get_transactions_by_id | [get_transactions_by_id_request](#koinos-rpc-transaction_store-get_transactions_by_id_request) |  |  |






<a name="koinos-rpc-transaction_store-transaction_store_response"></a>

### transaction_store_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| get_transactions_by_id | [get_transactions_by_id_response](#koinos-rpc-transaction_store-get_transactions_by_id_response) |  |  |





 

 

 

 



<a name="koinos_rpc_chain_chain_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/chain/chain_rpc.proto



<a name="koinos-rpc-chain-chain_request"></a>

### chain_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| submit_block | [submit_block_request](#koinos-rpc-chain-submit_block_request) |  |  |
| submit_transaction | [submit_transaction_request](#koinos-rpc-chain-submit_transaction_request) |  |  |
| get_head_info | [get_head_info_request](#koinos-rpc-chain-get_head_info_request) |  |  |
| get_chain_id | [get_chain_id_request](#koinos-rpc-chain-get_chain_id_request) |  |  |
| get_fork_heads | [get_fork_heads_request](#koinos-rpc-chain-get_fork_heads_request) |  |  |
| read_contract | [read_contract_request](#koinos-rpc-chain-read_contract_request) |  |  |
| get_account_nonce | [get_account_nonce_request](#koinos-rpc-chain-get_account_nonce_request) |  |  |
| get_account_rc | [get_account_rc_request](#koinos-rpc-chain-get_account_rc_request) |  |  |
| get_resource_limits | [get_resource_limits_request](#koinos-rpc-chain-get_resource_limits_request) |  |  |






<a name="koinos-rpc-chain-chain_response"></a>

### chain_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| submit_block | [submit_block_response](#koinos-rpc-chain-submit_block_response) |  |  |
| submit_transaction | [submit_transaction_response](#koinos-rpc-chain-submit_transaction_response) |  |  |
| get_head_info | [get_head_info_response](#koinos-rpc-chain-get_head_info_response) |  |  |
| get_chain_id | [get_chain_id_response](#koinos-rpc-chain-get_chain_id_response) |  |  |
| get_fork_heads | [get_fork_heads_response](#koinos-rpc-chain-get_fork_heads_response) |  |  |
| read_contract | [read_contract_response](#koinos-rpc-chain-read_contract_response) |  |  |
| get_account_nonce | [get_account_nonce_response](#koinos-rpc-chain-get_account_nonce_response) |  |  |
| get_account_rc | [get_account_rc_response](#koinos-rpc-chain-get_account_rc_response) |  |  |
| get_resource_limits | [get_resource_limits_response](#koinos-rpc-chain-get_resource_limits_response) |  |  |






<a name="koinos-rpc-chain-get_account_nonce_request"></a>

### get_account_nonce_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account | [bytes](#bytes) |  |  |






<a name="koinos-rpc-chain-get_account_nonce_response"></a>

### get_account_nonce_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| nonce | [bytes](#bytes) |  |  |






<a name="koinos-rpc-chain-get_account_rc_request"></a>

### get_account_rc_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account | [bytes](#bytes) |  |  |






<a name="koinos-rpc-chain-get_account_rc_response"></a>

### get_account_rc_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rc | [uint64](#uint64) |  |  |






<a name="koinos-rpc-chain-get_chain_id_request"></a>

### get_chain_id_request







<a name="koinos-rpc-chain-get_chain_id_response"></a>

### get_chain_id_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chain_id | [bytes](#bytes) |  |  |






<a name="koinos-rpc-chain-get_fork_heads_request"></a>

### get_fork_heads_request







<a name="koinos-rpc-chain-get_fork_heads_response"></a>

### get_fork_heads_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| last_irreversible_block | [koinos.block_topology](#koinos-block_topology) |  |  |
| fork_heads | [koinos.block_topology](#koinos-block_topology) | repeated |  |






<a name="koinos-rpc-chain-get_head_info_request"></a>

### get_head_info_request







<a name="koinos-rpc-chain-get_head_info_response"></a>

### get_head_info_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| head_topology | [koinos.block_topology](#koinos-block_topology) |  |  |
| last_irreversible_block | [uint64](#uint64) |  |  |
| head_state_merkle_root | [bytes](#bytes) |  |  |
| head_block_time | [uint64](#uint64) |  |  |






<a name="koinos-rpc-chain-get_resource_limits_request"></a>

### get_resource_limits_request







<a name="koinos-rpc-chain-get_resource_limits_response"></a>

### get_resource_limits_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| resource_limit_data | [koinos.chain.resource_limit_data](#koinos-chain-resource_limit_data) |  |  |






<a name="koinos-rpc-chain-read_contract_request"></a>

### read_contract_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| contract_id | [bytes](#bytes) |  |  |
| entry_point | [uint32](#uint32) |  |  |
| args | [bytes](#bytes) |  |  |






<a name="koinos-rpc-chain-read_contract_response"></a>

### read_contract_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| result | [bytes](#bytes) |  |  |
| logs | [string](#string) | repeated |  |






<a name="koinos-rpc-chain-submit_block_request"></a>

### submit_block_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| block | [koinos.protocol.block](#koinos-protocol-block) |  |  |






<a name="koinos-rpc-chain-submit_block_response"></a>

### submit_block_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| receipt | [koinos.protocol.block_receipt](#koinos-protocol-block_receipt) |  |  |






<a name="koinos-rpc-chain-submit_transaction_request"></a>

### submit_transaction_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction | [koinos.protocol.transaction](#koinos-protocol-transaction) |  |  |
| broadcast | [bool](#bool) |  |  |






<a name="koinos-rpc-chain-submit_transaction_response"></a>

### submit_transaction_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| receipt | [koinos.protocol.transaction_receipt](#koinos-protocol-transaction_receipt) |  |  |





 

 

 

 



<a name="koinos_rpc_block_store_block_store_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/block_store/block_store_rpc.proto



<a name="koinos-rpc-block_store-add_block_request"></a>

### add_block_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| block_to_add | [koinos.protocol.block](#koinos-protocol-block) |  |  |
| receipt_to_add | [koinos.protocol.block_receipt](#koinos-protocol-block_receipt) |  |  |






<a name="koinos-rpc-block_store-add_block_response"></a>

### add_block_response







<a name="koinos-rpc-block_store-block_store_request"></a>

### block_store_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| get_blocks_by_id | [get_blocks_by_id_request](#koinos-rpc-block_store-get_blocks_by_id_request) |  |  |
| get_blocks_by_height | [get_blocks_by_height_request](#koinos-rpc-block_store-get_blocks_by_height_request) |  |  |
| add_block | [add_block_request](#koinos-rpc-block_store-add_block_request) |  |  |
| get_highest_block | [get_highest_block_request](#koinos-rpc-block_store-get_highest_block_request) |  |  |






<a name="koinos-rpc-block_store-block_store_response"></a>

### block_store_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| get_blocks_by_id | [get_blocks_by_id_response](#koinos-rpc-block_store-get_blocks_by_id_response) |  |  |
| get_blocks_by_height | [get_blocks_by_height_response](#koinos-rpc-block_store-get_blocks_by_height_response) |  |  |
| add_block | [add_block_response](#koinos-rpc-block_store-add_block_response) |  |  |
| get_highest_block | [get_highest_block_response](#koinos-rpc-block_store-get_highest_block_response) |  |  |






<a name="koinos-rpc-block_store-get_blocks_by_height_request"></a>

### get_blocks_by_height_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| head_block_id | [bytes](#bytes) |  |  |
| ancestor_start_height | [uint64](#uint64) |  |  |
| num_blocks | [uint32](#uint32) |  |  |
| return_block | [bool](#bool) |  |  |
| return_receipt | [bool](#bool) |  |  |






<a name="koinos-rpc-block_store-get_blocks_by_height_response"></a>

### get_blocks_by_height_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| block_items | [koinos.block_store.block_item](#koinos-block_store-block_item) | repeated |  |






<a name="koinos-rpc-block_store-get_blocks_by_id_request"></a>

### get_blocks_by_id_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| block_ids | [bytes](#bytes) | repeated |  |
| return_block | [bool](#bool) |  |  |
| return_receipt | [bool](#bool) |  |  |






<a name="koinos-rpc-block_store-get_blocks_by_id_response"></a>

### get_blocks_by_id_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| block_items | [koinos.block_store.block_item](#koinos-block_store-block_item) | repeated |  |






<a name="koinos-rpc-block_store-get_highest_block_request"></a>

### get_highest_block_request







<a name="koinos-rpc-block_store-get_highest_block_response"></a>

### get_highest_block_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| topology | [koinos.block_topology](#koinos-block_topology) |  |  |





 

 

 

 



<a name="koinos_rpc_p2p_p2p_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/p2p/p2p_rpc.proto



<a name="koinos-rpc-p2p-get_gossip_status_request"></a>

### get_gossip_status_request







<a name="koinos-rpc-p2p-get_gossip_status_response"></a>

### get_gossip_status_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| enabled | [bool](#bool) |  |  |






<a name="koinos-rpc-p2p-p2p_request"></a>

### p2p_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| get_gossip_status | [get_gossip_status_request](#koinos-rpc-p2p-get_gossip_status_request) |  |  |






<a name="koinos-rpc-p2p-p2p_response"></a>

### p2p_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| get_gossip_status | [get_gossip_status_response](#koinos-rpc-p2p-get_gossip_status_response) |  |  |





 

 

 

 



<a name="koinos_rpc_mempool_mempool_rpc-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## koinos/rpc/mempool/mempool_rpc.proto



<a name="koinos-rpc-mempool-check_pending_account_resources_request"></a>

### check_pending_account_resources_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payer | [bytes](#bytes) |  |  |
| max_payer_rc | [uint64](#uint64) |  |  |
| rc_limit | [uint64](#uint64) |  |  |






<a name="koinos-rpc-mempool-check_pending_account_resources_response"></a>

### check_pending_account_resources_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| success | [bool](#bool) |  |  |






<a name="koinos-rpc-mempool-get_pending_transactions_request"></a>

### get_pending_transactions_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| limit | [uint64](#uint64) |  |  |






<a name="koinos-rpc-mempool-get_pending_transactions_response"></a>

### get_pending_transactions_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pending_transactions | [pending_transaction](#koinos-rpc-mempool-pending_transaction) | repeated |  |






<a name="koinos-rpc-mempool-mempool_request"></a>

### mempool_request



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| check_pending_account_resources | [check_pending_account_resources_request](#koinos-rpc-mempool-check_pending_account_resources_request) |  |  |
| get_pending_transactions | [get_pending_transactions_request](#koinos-rpc-mempool-get_pending_transactions_request) |  |  |






<a name="koinos-rpc-mempool-mempool_response"></a>

### mempool_response



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reserved | [koinos.rpc.reserved_rpc](#koinos-rpc-reserved_rpc) |  |  |
| error | [koinos.rpc.error_response](#koinos-rpc-error_response) |  |  |
| check_pending_account_resources | [check_pending_account_resources_response](#koinos-rpc-mempool-check_pending_account_resources_response) |  |  |
| get_pending_transactions | [get_pending_transactions_response](#koinos-rpc-mempool-get_pending_transactions_response) |  |  |






<a name="koinos-rpc-mempool-pending_transaction"></a>

### pending_transaction



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction | [koinos.protocol.transaction](#koinos-protocol-transaction) |  |  |
| disk_storage_used | [uint64](#uint64) |  |  |
| network_bandwidth_used | [uint64](#uint64) |  |  |
| compute_bandwidth_used | [uint64](#uint64) |  |  |





 

 

 

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

