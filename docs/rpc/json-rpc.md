# JSON-RPC

Koinos supports user APIs via JSON-RPC. Each microservice defines its own API calls. The JSON-RPC microservice acts as a translation layer between JSON-RPC and the internal message format. Koinos uses a dotted decimal system to route API requests to the correct microservice. Microservices can be called with their fully qualified namespace or by the microservice name.  For example, to call `get_head_info` in the Chain microservice you would call `"method":"koinos.rpc.chain.get_head_info"` or `"method":"chain.get_head_info"`.

## Descriptor files

The JSON-RPC microservice works by reading Protobuf descriptor files to parse and route API calls. By default, the Koinos Proto descriptor file is provided to handle API calls for Koinos microservices. API calls for additional microservices can be handled by providing the JSON-RPC microservice with your own Protobuf descriptor file.

## Examples

Here are some example RPC requests. All APIs are a work in progress and are subject to change.

All current APIs are defined in [Koinos Proto](https://github.com/koinos/koinos-proto). All files name `*_rpc.proto` defined API types for the particular microservice.

### Get block

In `koinos/rpc/block_store/block_store_rpc.proto`, there is `get_blocks_by_id_request`. This corresponds to the API call `block_store.get_blocks_by_id`. The corresponding JSON-RPC call would be:

```console
$ curl -d '{"jsonrpc":"2.0", "method":"block_store.get_blocks_by_id", "params":{"block_id":["EiCX+ssYyo0m73WLY0VZ2W8EZKYs9s34zvwmE4h2EUh7lQ=="], "return_block":true, "return_receipt":false}, "id":0}' http://localhost:8080/
```

This should return something like this:

```json
{"jsonrpc":"2.0","result":{"block_items":[{"block_id":"EiCX+ssYyo0m73WLY0VZ2W8EZKYs9s34zvwmE4h2EUh7lQ==","block_height":"964","block":{"id":"EiCX+ssYyo0m73WLY0VZ2W8EZKYs9s34zvwmE4h2EUh7lQ==","header":{"previous":"EiADKmeXbxQQuzkUPXFqf3qmdQ8hWQU5mub+xjEVDjSJAg==","height":"964","timestamp":"1633721336872"},"active":"CiISIOOwxEKY/BwUmvv0yJlvuSQnrkHkZJuTTKSVmRt4UrhVEiISIC26XbwznnMWrqJoP6+DnBt7HuIxPbeSESWIEY3wZqo1GhkAzuB70A1bDr3jPg1Zw671LCd55aJxEhPB","passive":"","signature_data":"CiBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAASY4xJBIDW9mt9V/owtOVuz3JNklOEJpyWM2KQ0OF0CXFKVCcRTUZv3B9rRsRd9paOeurixVds965X2aR/H85g8qba0Hm4=","transactions":[]},"receipt":null}]},"id":0}
```

### Get head block

```console
$ curl -d '{"jsonrpc":"2.0", "method":"chain.get_head_info", "params":{}, "id":1}' http://localhost:8080/
```

```json
{"jsonrpc":"2.0","result":{"head_topology":{"id":"EiD5jBaH29gjxO4XtP/kwYd618y8HgaqLHH6NiyfnHib+Q==","height":"966","previous":"EiDCzx9yh3EgpmpOyCjJ24aGL+PlECehkZ8IzR4ALrU4rg=="},"last_irreversible_block":"906"},"id":1}
```
