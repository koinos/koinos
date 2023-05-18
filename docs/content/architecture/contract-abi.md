# Contract ABI

To interact with smart contracts, Koinos tooling requires an Application Binary Interface (ABI). This ABI is a json file that describes what functions a contract has available and how to interact with it. Here is an example ABI for the KOIN Contract.

``` json
{
   "methods" : {
      "name": {
         "argument"    : "koinos.contracts.token.name_arguments",
         "return"      : "koinos.contracts.token.name_result",
         "entry-point" : "0x76ea4297",
         "description" : "Returns the token's name",
         "read-only"   : true
      },
      "symbol": {
         "argument"    : "koinos.contracts.token.symbol_arguments",
         "return"      : "koinos.contracts.token.symbol_result",
         "entry-point" : "0x7e794b24",
         "description" : "Returns the token's symbol",
         "read-only"   : true
      },
      "decimals": {
         "argument"    : "koinos.contracts.token.decimals_arguments",
         "return"      : "koinos.contracts.token.decimals_result",
         "entry-point" : "0x59dc15ce",
         "description" : "Return the token's decimal precision",
         "read-only"   : true
      },
      "total_supply": {
         "argument"    : "koinos.contracts.token.total_supply_arguments",
         "return"      : "koinos.contracts.token.total_supply_result",
         "entry_point" : "0xcf2e8212",
         "description" : "Mints the token's total supply",
         "read-only"   : true
      },
      "balance_of": {
         "argument"    : "koinos.contracts.token.balance_of_arguments",
         "return"      : "koinos.contracts.token.balance_of_result",
         "entry-point" : "0x15619248",
         "description" : "Checks the balance at an address",
         "read-only"   : true
      },
      "transfer": {
         "argument"    : "koinos.contracts.token.transfer_arguments",
         "return"      : "koinos.contracts.token.transfer_result",
         "entry-point" : "0x62efa292",
         "description" : "Transfers the token",
         "read-only"   : false
      },
      "mint": {
         "argument"    : "koinos.contracts.token.mint_arguments",
         "return"      : "koinos.contracts.token.mint_result",
         "entry-point" : "0xc2f82bdc",
         "description" : "Mints the token",
         "read-only"   : false
      }
   },
   "types" : "CssCChRrb2lub3Mvb3B0aW9ucy5wcm90bxIGa29pbm9zGiBnb29nbGUvcHJvdG9idWYvZGVzY3JpcHRvci5wcm90byptCgpieXRlc190eXBlEgoKBkJBU0U2NBAAEgoKBkJBU0U1OBABEgcKA0hFWBACEgwKCEJMT0NLX0lEEAMSEgoOVFJBTlNBQ1RJT05fSUQQBBIPCgtDT05UUkFDVF9JRBAFEgsKB0FERFJFU1MQBjpiChFrb2lub3NfYnl0ZXNfdHlwZRIdLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE9wdGlvbnMY0IYDIAEoDjISLmtvaW5vcy5ieXRlc190eXBlUg9rb2lub3NCeXRlc1R5cGWIAQFCLlosZ2l0aHViLmNvbS9rb2lub3Mva29pbm9zLXByb3RvLWdvbGFuZy9rb2lub3NiBnByb3RvMwqQBwoia29pbm9zL2NvbnRyYWN0cy90b2tlbi90b2tlbi5wcm90bxIWa29pbm9zLmNvbnRyYWN0cy50b2tlbhoUa29pbm9zL29wdGlvbnMucHJvdG8iEAoObmFtZV9hcmd1bWVudHMiIwoLbmFtZV9yZXN1bHQSFAoFdmFsdWUYASABKAlSBXZhbHVlIhIKEHN5bWJvbF9hcmd1bWVudHMiJQoNc3ltYm9sX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUiFAoSZGVjaW1hbHNfYXJndW1lbnRzIicKD2RlY2ltYWxzX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUiGAoWdG90YWxfc3VwcGx5X2FyZ3VtZW50cyIvChN0b3RhbF9zdXBwbHlfcmVzdWx0EhgKBXZhbHVlGAEgASgEQgIwAVIFdmFsdWUiMgoUYmFsYW5jZV9vZl9hcmd1bWVudHMSGgoFb3duZXIYASABKAxCBIC1GAZSBW93bmVyIi0KEWJhbGFuY2Vfb2ZfcmVzdWx0EhgKBXZhbHVlGAEgASgEQgIwAVIFdmFsdWUiXgoSdHJhbnNmZXJfYXJndW1lbnRzEhgKBGZyb20YASABKAxCBIC1GAZSBGZyb20SFAoCdG8YAiABKAxCBIC1GAZSAnRvEhgKBXZhbHVlGAMgASgEQgIwAVIFdmFsdWUiJwoPdHJhbnNmZXJfcmVzdWx0EhQKBXZhbHVlGAEgASgIUgV2YWx1ZSJACg5taW50X2FyZ3VtZW50cxIUCgJ0bxgBIAEoDEIEgLUYBlICdG8SGAoFdmFsdWUYAiABKARCAjABUgV2YWx1ZSIjCgttaW50X3Jlc3VsdBIUCgV2YWx1ZRgBIAEoCFIFdmFsdWUiKgoOYmFsYW5jZV9vYmplY3QSGAoFdmFsdWUYASABKARCAjABUgV2YWx1ZSJ5ChNtYW5hX2JhbGFuY2Vfb2JqZWN0EhwKB2JhbGFuY2UYASABKARCAjABUgdiYWxhbmNlEhYKBG1hbmEYAiABKARCAjABUgRtYW5hEiwKEGxhc3RfbWFuYV91cGRhdGUYAyABKARCAjABUg5sYXN0TWFuYVVwZGF0ZUI+WjxnaXRodWIuY29tL2tvaW5vcy9rb2lub3MtcHJvdG8tZ29sYW5nL2tvaW5vcy9jb250cmFjdHMvdG9rZW5iBnByb3RvMw=="
}
```

The fields for each entry in `methods` are pretty self explanatory. The argument and return type names are fully qualified types generated from Protobuf. In this case the generating file is:

``` proto
syntax = "proto3";

package koinos.contracts.token;
option go_package = "github.com/koinos/koinos-proto-golang/koinos/contracts/token";

import "koinos/options.proto";

message name_arguments {}

message name_result {
   string value = 1;
}

message symbol_arguments {}

message symbol_result {
   string value = 1;
}

message decimals_arguments {}

message decimals_result {
   uint32 value = 1;
}

message total_supply_arguments {}

message total_supply_result {
   uint64 value = 1 [jstype = JS_STRING];
}

message balance_of_arguments {
   bytes owner = 1 [(btype) = ADDRESS];
}

message balance_of_result {
   uint64 value = 1 [jstype = JS_STRING];
}

message transfer_arguments {
   bytes from = 1 [(btype) = ADDRESS];
   bytes to = 2 [(btype) = ADDRESS];
   uint64 value = 3 [jstype = JS_STRING];
}

message transfer_result {
   bool value = 1;
}

message mint_arguments {
   bytes to = 1 [(btype) = ADDRESS];
   uint64 value = 2 [jstype = JS_STRING];
}

message mint_result {
   bool value = 1;
}

message balance_object {
   uint64 value = 1 [jstype = JS_STRING];
}

message mana_balance_object {
   uint64 balance = 1 [jstype = JS_STRING];
   uint64 mana = 2 [jstype = JS_STRING];
   uint64 last_mana_update = 3 [jstype = JS_STRING];
}
```

The base64 encoded string for the field `types` is a base64 encoded protobuf descriptor for these types. To generate this descriptor you can run the following commands in `koinos-proto`.

```console
$ protoc --descriptor_set_out=koin.pb koinos/contracts/token/token.proto koinos/options.proto
$ cat koin.pb | base64
```

> _**Note:** You need to include both the contract proto file (`koinos/contracts/token/token.proto` and any non-protobuf files it includes (`koinos/options.proto`). This will create the smallest possible ABI that can be used with various Koinos tooling._
