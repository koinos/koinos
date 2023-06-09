# Smart contract custom types

This tutorial aims to demonstrate how to create smart contracts using custom types in order to interact with it. We will create a decentralized calculator to accomplish this. To follow this tutorial, clone the contract examples from [GitHub](https://github.com/koinos/koinos-contract-examples).

## Setting up the project

C++ smart contracts are built using either Docker or the CMake build system. For this tutorial, we will use CMake. We will assume you have already set up your CDT. If you have not, the [Contract developer guide](../../quickstart/contract-developer-guide.md) documents this process. Let us begin by setting up our directory structure.

```console
$ cp -R cmake_project calculator_contract
$ cp contracts/calculator/calc.cpp calculator_contract/src/calc.cpp
$ cp contracts/calculator/calc.proto calculator_contract/types/calc.proto
```

## Defining custom types

Building a contract will usually consist of behaviors and data. The behavior is defined by the smart contract. But the data is defined by Protobuf. We generate data structures with Protobuf so that the smart contract can easily integrate with other Koinos tools. We have defined the arguments and results we will use in our calculator. We use the `*_arguments` convention for contract function arguments and `*_result` for contract function results.

```proto
syntax = "proto3";

package koinos.contracts.calc;

message add_arguments {
  int64 x = 1;
  int64 y = 2;
}

message add_result {
  int64 value = 1;
}

message sub_arguments {
  int64 x = 1;
  int64 y = 2;
}

message sub_result {
  int64 value = 1;
}

message mul_arguments {
  int64 x = 1;
  int64 y = 2;
}

message mul_result {
  int64 value = 1;
}

message div_arguments {
  int64 x = 1;
  int64 y = 2;
}

message div_result {
  int64 value = 1;
}
```

## Writing the implementation

Each smart contract must define a `main()`. Within `main()` we will get the contract's arguments and entry points and dispatch to the correct function from there. Currently, this must be implemented manually. There is a decent amount of boiler plate currently to deserialize and serialize data. This all comes from the generated Protobuf types.

```c++
#include <koinos/system/system_calls.hpp>

#include <koinos/buffer.hpp>
#include <koinos/common.h>

#include <calc.h>

using namespace koinos;
using namespace koinos::contracts;

enum entries : uint32_t
{
   add_entry = 1,
   sub_entry = 2,
   mul_entry = 3,
   div_entry = 4
};

class calculator
{
public:
   calc::add_result add( int64_t x, int64_t y ) noexcept;
   calc::sub_result sub( int64_t x, int64_t y ) noexcept;
   calc::mul_result mul( int64_t x, int64_t y ) noexcept;
   calc::div_result div( int64_t x, int64_t y ) noexcept;
};

calc::add_result calculator::add( int64_t x, int64_t y ) noexcept
{
   calc::add_result res;
   res.set_value( x + y );
   return res;
}

calc::sub_result calculator::sub( int64_t x, int64_t y ) noexcept
{
   calc::sub_result res;
   res.set_value( x - y );
   return res;
}

calc::mul_result calculator::mul( int64_t x, int64_t y ) noexcept
{
   calc::mul_result res;
   res.set_value( x * y );
   return res;
}

calc::div_result calculator::div( int64_t x, int64_t y ) noexcept
{
   calc::div_result res;

   if ( y == 0 )
   {
      system::print( "cannot divide by zero" );
      system::exit( 1 );
   }

   res.set_value( x / y );
   return res;
}

int main()
{
   auto [ entry_point, args ] = system::get_arguments();

   std::array< uint8_t, 32 > retbuf;

   koinos::read_buffer rdbuf( (uint8_t*)args.c_str(), args.size() );
   koinos::write_buffer buffer( retbuf.data(), retbuf.size() );

   calculator c;

   switch( entry_point )
   {
      case entries::add_entry:
      {
         calc::add_arguments args;
         args.deserialize( rdbuf );

         auto res = c.add( args.x(), args.y() );
         res.serialize( buffer );
         break;
      }
      case entries::sub_entry:
      {
         calc::sub_arguments args;
         args.deserialize( rdbuf );

         auto res = c.sub( args.x(), args.y() );
         res.serialize( buffer );
         break;
      }
      case entries::mul_entry:
      {
         calc::mul_arguments args;
         args.deserialize( rdbuf );

         auto res = c.mul( args.x(), args.y() );
         res.serialize( buffer );
         break;
      }
      case entries::div_entry:
      {
         calc::div_arguments args;
         args.deserialize( rdbuf );

         auto res = c.div( args.x(), args.y() );
         res.serialize( buffer );
         break;
      }
      default:
         system::exit_contract( 1 );
   }

   system::result r;
   r.mutable_object().set( buffer.data(), buffer.get_size() );

   system::exit( 0, r );
}
```

> _**Note:** We have an included header called `calc.h`, this was generated automatically based off our `calc.proto` definitions._

## Compiling the smart contract

If you have not already prepared your environment please refer to the [Contract developer guide](../../quickstart/contract-developer-guide.md). We
will now use the [Koinos C++ Software Developer Kit (SDK)](https://github.com/koinos/koinos-sdk-cpp) to compile the smart contract.

```console
$ mkdir build
$ cd build
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=${KOINOS_CDT_ROOT}/cmake/koinos-wasm-toolchain.cmake ..
$ make -j
```

This will create two build artifacts, `build/src/contract.wasm` and `build/types/types.pb`. We will need these later.

## Creating the ABI file

We will use the [Koinos Command Line Interface (CLI)](https://github.com/koinos/koinos-cli) to interact with this contract on the blockchain. We need the Application Binary Interface (ABI) to inform the CLI how to invoke methods on the contract. For more information about the ABI file please refer to the [Contract ABI](../../architecture/contract-abi.md) section.

The contract examples repo already contains the [ABI file](https://github.com/koinos/koinos-contract-examples/blob/master/contracts/calculator/calc.abi). The ABI File contains JSON information about each of the entry points as well as the Base64 encoded protobuf descriptor file (`types.pb`) that was generated during compilation. Encoding the Base64 descriptor file can be done with a simple command.

```console
$ cat types/types.pb | base64
Cq4DCgpjYWxjLnByb3RvEhVrb2lub3MuY29udHJhY3RzLmNhbGMiKwoNYWRkX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKYWRkX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNc3ViX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKc3ViX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNbXVsX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKbXVsX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNZGl2X2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKZGl2X3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWVCPVo7Z2l0aHViLmNvbS9rb2lub3Mva29pbm9zLXByb3RvLWdvbGFuZy9rb2lub3MvY29udHJhY3RzL2NhbGNiBnByb3RvMw==
```

```json
{
   "methods" : {
      "add": {
         "argument"    : "koinos.contracts.calc.add_arguments",
         "return"      : "koinos.contracts.calc.add_result",
         "entry_point" : "0x01",
         "description" : "Add two integers",
         "read-only"   : true
      },
      "sub": {
         "argument"    : "koinos.contracts.calc.sub_arguments",
         "return"      : "koinos.contracts.calc.sub_result",
         "entry_point" : "0x02",
         "description" : "Subtract two integers",
         "read-only"   : true
      },
      "mul": {
         "argument"    : "koinos.contracts.calc.mul_arguments",
         "return"      : "koinos.contracts.calc.mul_result",
         "entry_point" : "0x03",
         "description" : "Multiply two integers",
         "read-only"   : true
      },
      "div": {
         "argument"    : "koinos.contracts.calc.div_arguments",
         "return"      : "koinos.contracts.calc.div_result",
         "entry_point" : "0x04",
         "description" : "Divide two integers",
         "read-only"   : true
      }
   },
   "types" : "Cq4DCgpjYWxjLnByb3RvEhVrb2lub3MuY29udHJhY3RzLmNhbGMiKwoNYWRkX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKYWRkX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNc3ViX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKc3ViX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNbXVsX2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKbXVsX3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUiKwoNZGl2X2FyZ3VtZW50cxIMCgF4GAEgASgDUgF4EgwKAXkYAiABKANSAXkiIgoKZGl2X3Jlc3VsdBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWVCPVo7Z2l0aHViLmNvbS9rb2lub3Mva29pbm9zLXByb3RvLWdvbGFuZy9rb2lub3MvY29udHJhY3RzL2NhbGNiBnByb3RvMw=="
}
```

> _**Note:** The `"types"` definition comes from the Base64 of the `types.pb`._

## Uploading and interaction

It is recommended you create a new address for your contract. You will also require sufficient mana to perform the upload. Once you have done that we can
upload our contract.

```
🔓 > upload contract.wasm
Contract uploaded with address 1MxjuQygG8Ek2XsArvFNwLAa2uns1VfY7e
Submitted transaction with ID 0x1220c3ee14dd94d142e618f46defcb06d206975a610e55c7233e70fb495ac47a2737
```

Once that block is accepted our contract is on the chain. We now must inform the CLI how to interact with the contract. We do this by registering the name, address, and ABI. With the ABI file `calc.abi` and smart contract `contract.wasm` in the current working directory we execute the following command in the CLI.

```
🔓 > register calc 1MxjuQygG8Ek2XsArvFNwLAa2uns1VfY7e calc.abi
Contract 'calc' at address 1MxjuQygG8Ek2XsArvFNwLAa2uns1VfY7e registered
```

You will find that the CLI now has additional capabilities.

```
🔓 > list
...
calc.add        - Add two integers
calc.div        - Divide two integers
calc.mul        - Multiply two integers
calc.sub        - Subtract two integers
...
```

Let us invoke some of our methods.

```
🔓 > calc.div 40040675 5
value:8008135
```
