# AssemblyScript smart contract tutorial

_Originally published by Roamin on [Hashnode](https://hashnode.com/@Roamin)_

In this tutorial we will create a simple smart contract in AssemblyScript, compile it to a Web Assembly, and deploy it to the Koinos Harbinger test network.

## Setting up the dev environment

### Install NodeJS

We will need NodeJS installed in order to develop, build, and deploy the smart contract. If it is not yet installed on your system please head over to [the NodeJS website](https://nodejs.org/) and follow the installation guide.

### Download the SDK CLI

In this example we will be using the [Yarn package manger](https://yarnpkg.com/getting-started/install), but NPM will work as well.

Install the Koinos AssemblyScript CLI by running this command:

```console
$ yarn global add @koinos/sdk-as-cli
```

The AS CLI should be installed globally, we can check by running this command:

```console
$ $(yarn global bin)/koinos-sdk-as-cli -V
```

Alternatively, you can add `$(yarn global bin)` to your `PATH` and run `koinos-sdk-as-cli` directly (The remainder of this guide assumes this).

The output should read `1.0.2` or the current version of the [AS SDK CLI Node package](https://www.npmjs.com/package/@koinos/sdk-as-cli).

## Create the smart contract

To create the smart contract boilerplate we can run the following command:

```console
$ koinos-sdk-as-cli create myawesomecontract
```

The AS CLI command `create` takes one argument which is the name of the contract in this case the smart contract is called `myawesomecontract`.

The output should look something like this:

```
Generating contract at "/Users/rr/Documents/blockchain/tutorial/myawesomecontract"...

Contract successfully generated!

You're all set! Run the following set of commands to verify that the generated contract is correctly setup:

  cd /Users/rr/Documents/blockchain/tutorial/myawesomecontract && yarn install && yarn build:debug && yarn test
```

At the end of the output, the CLI logs a set of commands that we can run to check to build and test our contract. Move to the `myawesomecontract` directory using the commands above, replacing the directory with yours.

```console
$ cd /Users/rr/Documents/blockchain/tutorial/myawesomecontact
```

Now run the following commands:

```console
$ yarn install && yarn build:debug && yarn test
```

Let us look at each command and break down what it does.

- `yarn install`: Installs all the dependencies needed to compile and test a Koinos smart contract. This only needs to be ran once.
- `yarn build:debug`: Compiles the smart contract into Web Assembly using a debug build.
- `yarn test`: Runs the unit tests on the compiled smart contract.

If successful the output should look something like this:

```
[Describe]: contract

[Log] Hello, World!
 [Success]: ✔ should return 'hello, NAME!' RTrace: +21

    [File]: assembly/__tests__/Myawesomecontract.spec.ts
  [Groups]: 2 pass, 2 total
  [Result]: ✔ PASS
[Snapshot]: 0 total, 0 added, 0 removed, 0 different
 [Summary]: 1 pass,  0 fail, 1 total
    [Time]: 12.109ms

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  [Result]: ✔ PASS
   [Files]: 1 total
  [Groups]: 2 count, 2 pass
   [Tests]: 1 pass, 0 fail, 1 total
    [Time]: 3035.096ms
┌───────────────────────────────┬───────┬───────┬──────┬──────┬───────────┐
│ File                          │ Total │ Block │ Func │ Expr │ Uncovered │
├───────────────────────────────┼───────┼───────┼──────┼──────┼───────────┤
│ assembly/Myawesomecontract.ts │ 100%  │ 100%  │ 100% │ N/A  │           │
├───────────────────────────────┼───────┼───────┼──────┼──────┼───────────┤
│ total                         │ 100%  │ 100%  │ 100% │ N/A  │           │
└───────────────────────────────┴───────┴───────┴──────┴──────┴───────────┘

Done in 3.28s.
```

The CLI generates a boilerplate smart contract which allows us to quickly setup a new contract and make sure the development environment is working properly.

### The generated smart contract code


Let's open the `myawesomecontract` directory in our code editor. The content should be similar to this:

![file structure image](./images/vscode-file-structure-image.png "File structure")

We will mainly focus on the assembly directory, it's where all the smart contract-related code lives.

#### `assembly` directory:

![assembly folder image](./images/assembly-folder-image.png "Assembly directory")

- `__tests__` contains the unit tests for the contract.
- `proto` contains custom proto files for the contract.
- `index.ts` contains the logical entry point of the contract.
- `Myawesomecontract.boilerplate.ts` contains boilerplate auto-generated example code based on the proto files.
- `Myawesomecontract.ts` contains the actual code of the smart contract.
- `tsconfig.json` tells the IDE what types are available in AssemblyScript, AS is like TypeScript but with WebAssembly types.

#### `proto` directory:

The Koinos blockchain  leverages Google's [Protocol Buffers](https://developers.google.com/protocol-buffers) (Protobuf).

> Protocol buffers are Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data – think XML, but smaller, faster, and simpler.

The `proto` directory should look like this:

![proto folder image](./images/proto-folder-image.png "Proto directory")

- `myawesomecontract.proto` contains the protocol buffers definitions.
- `myawesomecontract.ts` is auto-generated AssemblyScript code based on the above proto file.

Let's have a look at `myawesomecontract.proto`:

```proto
syntax = "proto3";

package myawesomecontract;

// @description Says Hello!
// @read-only true
message hello_arguments {
  string name = 1;
}

message hello_result {
  string value = 1;
}
```

We will focus on the important parts of this file:

- `package myawesomecontract` is package name to which this proto file belongs, in this case, it's the name of the smart contract.
- `message hello_arguments` is divided into 3 parts:
  - `message` indicates that we are declaring a new proto message.
  - `hello` is the name of the smart contract function this message describes, in this case `hello`.
  - `arguments` describes the arguments of the function.
- `message hello_result` the message that describes the result of the function `hello`.

A smart contract function always contains an arguments and result message (even if the message is empty). Each arguments message can have the following commented annotations:

- `@description` describes what the function does.
- `@read-only` indicates is a read only function or not. Read only functions cannot write the blockchain database.

Inside each proto message are properties. In this case, `string name = 1;`, declares a property, `name`, of type, `string`, at field number, `1`. For further information about the Protobuf definition language, you can read [Google's Protobuf documentation](https://protobuf.dev/programming-guides/proto3/).

After creating or modifying the proto we will need to compile it so that the new AS files get generated. Again, we can use the CLI to do this.

```console
$ yarn build:debug
```

This command will re/generate `myawesomecontract.ts`, `index.ts`, and `myawesomecontract.boilerplate.ts`.

#### Contract files

Let's have a look at the generated `myawesomecontract.boilerplate.ts`. Comments have been added to explain each part of the code that hasn't been previously explained.

```ts
// Import the different helpers available in the Koinos AS SDK
import { System, Protobuf, authority } from "@koinos/sdk-as";

// Import the AS generated proto file myawesomecontract.ts
import { myawesomecontract } from "./proto/myawesomecontract";

// Exports the contract class
export class Myawesomecontract {

  // Optional description of the hello function
  hello(
    // Arguments of the hello function, which are of type "hello_arguments"
    args: myawesomecontract.hello_arguments
  ):
   // Result of the hello function, which is of type "hello_result"
   myawesomecontract.hello_result {

    /*
      "name" variable that's directly extracted from the "hello_arguments"
      that we described in our proto file
    */
    // const name = args.name;

    // This where you would describe your smart contract function's logic
    // "res" variable that is of type "hello_result"
    const res = new myawesomecontract.hello_result();

    /*
      "value" variable that's directly extracted from the "hello_result"
      that we described in our proto file
    */

    // res.value = ;

    return res;
  }
}
```

The generated boilerplate is useful when we are creating the contract or when updating `*.proto`. It will generate the boilerplate code of the smart contract functions that can be used as an example when updating a smart contract in development.

Let's have a look at the actual smart contract implementation. Comments have been added to the code that hasn't been explained previously:

`myawesomecontract.ts`:

```ts
import { System } from "@koinos/sdk-as";
import { myawesomecontract } from "./proto/myawesomecontract";

export class Myawesomecontract {
  hello(args: myawesomecontract.hello_arguments): myawesomecontract.hello_result {
    const name = args.name!;

    const res = new myawesomecontract.hello_result();

    // The result of the string "Hello, " + name
    res.value = `Hello, ${name}!`;

    // The system call/function "log"
    // will log `res.value` in the transactions' receipt
    System.log(res.value!);

    return res;
  }
}
```

#### `__tests__` directory:

In `__tests__` we should have a file called `myawesomecontract.spec.ts` containing unit tests for the smart contract.

Let's have a look at the actual unit test implementation. Comments have been added to the code that hasn't been explained previously:

``` ts
// Import the smart contract ts file
import { Myawesomecontract } from '../Myawesomecontract';

// Import the proto ts file
import { myawesomecontract } from '../proto/myawesomecontract';

// Define a test suite
describe('contract', () => {

  // Define a unit test
  it("should return 'hello, NAME!'", () => {
    // Create a new instance of the contract class
    const c = new Myawesomecontract();

    // Instantiate the arguments of the "hello" function
    const args = new myawesomecontract.hello_arguments('World');

    // Call the "hello" function
    const res = c.hello(args);

    // Check the result of the "hello" function is what is expected
    expect(res.value).toStrictEqual('Hello, World!');
  });
});
```

## Modify the generated smart contract code

Let's add a function that will simply add two numbers together and return the sum.

To add a function to our contract, we need to modify our `proto` file. Let's add an `add` function:

```proto
// @description Adds 2 numbers together
// @read-only true
message add_arguments {
  // "add" accepts an argument called "a" that is of type "uint64"
  uint64 a = 1;
  // "add" accepts an argument called "b" that is of type "uint64"
  uint64 b = 2;
}

message add_result {
  // "add" returns a result that has a property called "value"
  // "value" is of type "uint64"
  uint64 value = 1;
}
```

Now we need to regenerate the ts proto files based on our changes.

```console
$ yarn build:debug
```

This will generate the new boilerplate files, we also get the following error, that is because we have not added the function `add` to our contract yet:

```
ERROR TS2339: Property 'add' does not exist on type 'assembly/Myawesomecontract/Myawesomecontract'.

       const res = c.add(args);
                     ~~~
 in assembly/index.ts(27,21)

ERROR TS1140: Type argument expected.

       retbuf = Protobuf.encode(res, ProtoNamespace.add_result.encode);
                               ^
 in assembly/index.ts(28,31)

FAILURE 2 compile error(s)

```

To remedy this problem, let's open `Myawesomecontract.boilerplate.ts` and copy the following auto-generated code:

```ts
add(args: myawesomecontract.add_arguments): myawesomecontract.add_result {
  // const a = args.a;
  // const b = args.b;

  // YOUR CODE HERE

  const res = new myawesomecontract.add_result();

  // res.value = ;

  return res;
}
```

Open `Myawesomecontract.ts` and paste the new function within the class. Let's implement the `add` function as follows:

```ts
add(args: myawesomecontract.add_arguments): myawesomecontract.add_result {
  const a = args.a;
  const b = args.b;

  // "c" is just the addition of "a" and "b"
  // we use the "SafeMath" helper
  // this will ensure that our result won't overflow/underflow
  // It can be imported from "@koinos/sdk-as"
  const c = SafeMath.add(a, b);

  const res = new myawesomecontract.add_result();

  // we set the "value" with the above calculated "c"
  res.value = c;

  return res;
}
```

Make sure to modify the `import` line of `@koinos/sdk-as` to the following:

```ts
import { System, SafeMath } from "@koinos/sdk-as";
```

Now that our new function has been implemented, let's add a new unit test. Head over to `Myawesomecontract.spec.ts` and add the following unit test:

```ts
it("should add 2 numbers", () => {
	const c = new Myawesomecontract();

	const args = new myawesomecontract.add_arguments(4, 8);
	const res = c.add(args);

	expect(res.value).toStrictEqual(12);
});
```

Let's run our tests to make sure everything is working.

```console
$ yarn test
```

```
[Describe]: contract

[Log] Hello, World!
 [Success]: ✔ should return 'hello, NAME!' RTrace: +21
 [Success]: ✔ should add 2 numbers RTrace: +15

    [File]: assembly/__tests__/Myawesomecontract.spec.ts
  [Groups]: 2 pass, 2 total
  [Result]: ✔ PASS
[Snapshot]: 0 total, 0 added, 0 removed, 0 different
 [Summary]: 2 pass,  0 fail, 2 total
    [Time]: 12.685ms

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  [Result]: ✔ PASS
   [Files]: 1 total
  [Groups]: 2 count, 2 pass
   [Tests]: 2 pass, 0 fail, 2 total
    [Time]: 3102ms
┌───────────────────────────────┬───────┬───────┬──────┬──────┬───────────┐
│ File                          │ Total │ Block │ Func │ Expr │ Uncovered │
├───────────────────────────────┼───────┼───────┼──────┼──────┼───────────┤
│ assembly/Myawesomecontract.ts │ 100%  │ 100%  │ 100% │ N/A  │           │
├───────────────────────────────┼───────┼───────┼──────┼──────┼───────────┤
│ total                         │ 100%  │ 100%  │ 100% │ N/A  │           │
└───────────────────────────────┴───────┴───────┴──────┴──────┴───────────┘

Done in 3.34s.
```

We just added a new function to the contract and also made sure that it works.

Now that our smart contract is ready for deployment, let us build it in release mode:

```console
$ yarn build:release
```

## Upload to the Blockchain

We can now use the [Koinos CLI](https://github.com/koinos/koinos-cli) to upload our smart contract to the Koinos Harbinger test network.

If it's not yet installed, head over to Koinos CLI GitHub repo and install the latest [CLI release](https://github.com/koinos/koinos-cli/releases).

### Generate a wallet

Let's create a wallet so that we can interact with the Koinos blockchain.

By default, this release connects to, and reggisters contracts for, the Koinos Mainnet. We need to connect to the Harginger test network instead. Start by making a copy of `.koinosrc`.

```console
$ cp .koinosrc .mainnet-koinosrc
```

Modify `.koinosrc` to match the following:

```
connect https://harbinger-api.koinos.io
register_token koin 19JntSm8pSNETT9aHTwAUHC5RMoaSmgZPJ
register_token vhp 1JZqj7dDrK5LzvdJgufYBJNUFo88xBoWC8
register pob 198RuEouhgiiaQm7uGfaXS6jqZr6g6nyoR
register resources 19ivYkxhmtq1rzrmuv2TfeJYkTGo1UDz7a
register governance 19NiV19wCr6YZPhnNbN6emYrqaPjvTVpJQ
```

This `rc` file will connect to the Harbinger test network and register the test network system contracts. Start the CLI and connect to the Harbinger test network.

```
$ ./koinos-cli
```

You can run `list` to see all vailable commands:

```
🔐 > list
account_rc                                - Get the current resource credits for a given address (open wallet if blank)
address                                   - Show the currently opened wallet's address
call                                      - Call a smart contract
...
```

You can also run `help` against any command to learn more about it.

```
🔐 > help create
Create and open a new wallet file
Usage: create <filename:file> [password:string]
```

Let's create a new wallet:

```
🔐 > create my.wallet azerty
```

You should see output similar to this:

```
🔐 > create my.wallet azerty
Created and opened new wallet: my.wallet
Address: 19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE
```

You will see the address of your wallet instead of `19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE`. This address is how you and others can interact with your wallet. If you need to see your address again, you can with the `address` command.

We will need some test tokens `tKoin` to interact with the network. Follow the [Using the Discord Faucet](../using-the-faucet-on-discord.md) tutorial to get 100 `tKoin`.

Once succesful you can query your balance.

```
🔓 > koin.balance_of
100 KOIN
```

### Deploy the Smart Contract

We can upload the smart contract to the blockchain by issuing the following command:

```
🔓 > upload myawesomecontract/build/release/contract.wasm myawesomecontract/abi/myawesomecontract.abi
```

Uploading the ABI file is not mandatory but highly encouraged as this will allow users to interact with the contract in a more efficient manner.

This command should output a transaction ID as well as the Mana used to upload the contract:

```
🔓 > upload myawesomecontract/build/release/contract.wasm myawesomecontract/abi/myawesomecontract.abi
Contract uploaded with address 19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE
Transaction with ID 0x122096042fb2e2c085eb4e78cb80a4933e6cda21ebf65722e2c0f283f39a9ba40f2a containing 1 operations submitted.
Mana cost: 0.38643078 (Disk: 16472, Network: 17562, Compute: 177948)
```

__Important note:__ The wallet/address we use to upload a contract will be the address of the contract itself. This means that the address `19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE` is the address of the wallet we created earlier, but it is also the address of the contract. Smart contracts are users in Koinos. Additionally, the block size limit on the Koinos blockchain is set to 200kb which means that the contract's WASM files cannot exceed this size. If it does, splitting the logic into several smaller contracts would be neccessary.

As you can see, the upload cost us `0.38643078 Mana`. Mana is not a fee, but a regenerative resource intrinsic to each KOIN, which means we didn't spend any actual tKOIN (or KOIN on mainnet) to upload our contract.

We can check the transaction on the [block explorer](https://koinosblocks.com) by first setting the API node address (top right corner) to `https://harbinger-api.koinos.io`, refreshing, and then searching for the transaction ID `0x12205d19a5e9fc1a8d12478b7ff761c7b4619b9770404da2dff41d872cd0f0e6fdf8` (using your transaction ID as reported in the CLI).

### Interacting with the Smart Contract

Now that our smart contract and our ABI file have been successfully uploaded onto the Koinos blockchain test network, we can interact with it.

In the Koinos CLI, type the following command to register your contract:

```
🔓 > register mycontract 19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE
Contract 'mycontract' at address 19yp497RPiuWwsNUWp9cHWfbWUupHsRQLE registered
```

Because the we registered the contract, you can see it should up in the `list` command.

```
🔓 > list
...
mycontract.add                  - Adds 2 numbers together
mycontract.hello                - Says Hello!
...
```

The contract also shows up in command completion and `help`:

```
🔓 > help my
             mycontract.add    Adds 2 numbers together
             mycontract.hello  Says Hello!
🔓 > help mycontract.add
Adds 2 numbers together
Usage: mycontract.add <a:uint> <b:uint>
```

We can call the add function using the CLI:

```
🔓 > mycontract.add 40 2
value:  42
```

## Summary

In this tutorial we learned how to setup a smart contract development environment for Koinos. We saw how to generate a smart contract and add functionality to it. Finally, we uploaded the contract to the blockchain and interacted with it using the Koinos CLI.

There many more things you can do with a Koinos smart contract. The best next step is to familiarize yourself with the Koinos [system calls](../../architecture/system-calls). Using system calls you can persist data, interact with cryptographic functions, call other contracts, and much more.

We also have a thriving community of developers in the [Koinos Discord](https://discord.koinos.io). When you join, please say, "Hi!", join one of our developer focused conversations, or learn about the many DAPPs already being built on Koinos!
