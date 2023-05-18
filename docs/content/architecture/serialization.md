# Serialization

## Protocol buffers

Koinos utilizes [_Google Protocol Buffers_](https://developers.google.com/protocol-buffers/) for serializing data types between microservices and between the Koinos Blockchain Framework and the WASM VM. Protocol Buffers was chosen for a variety of reasons. The primary being the number of officially supported languages and flexibility of the specification to represent all cases required by Koinos.

## Canonicity

Protocol Buffers does not specifiy a deterministic serialization for each type. This is a feature of the protocol to increase flexibility. But when cryptographic integrity is required, this is a liability. Thankfully, the Protocol Buffers serialization is not difficult to understand and enforcing canonicity is relatively straight forward. Every field of a Protocol Buffers message must have an integer index. This is a natural sort order. Futhermore, maps are not guaranteeed to be serialized in any particular order. This appears to be due to the fact that not all targeted languages can guarantee a particular order (Golang purposefully randomizes the iteration order of a map to prevent devlopers from relying on a particular ordering). Koinos Blockchain Framework has no need of maps, so this is not an issue for us. From these restraints the canonical serialization is as follows:

- Serialize fields in field number order
- Do not allow maps

All messages that are cryptographically referenced or verified will be serialized using this serialization. The primary location where this will impact developers is transaction signing.
