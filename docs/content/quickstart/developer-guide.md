# Developer guide

## C++ projects

Koinos projects that are written in C++ utilize [CMake](https://cmake.org/) for generating build files. CMake is a flexible pre-build step that allows developers to utilize a variety of Integrated Development Environments (IDE).

Dependencies are handled using the [Hunter package manager](https://github.com/cpp-pm/hunter). Hunter will download the necessary dependencies and compile them on your development machine as well as cache the resulting libraries. Normally, a developer need not be aware of the Hunter mechanism - which is its great advantage. Be aware that the first time you generate a CMake project it will build the dependency cache increasing your build times. Subsequent calls to CMake will leverage the Hunter cache.

### Dependencies

You will need a modern C++ compiler as well as CMake to build Koinos C++ projects. This should be easily handled by your operating systems package manager.

#### macOS

```console
$ brew install cmake
```

> _**Note:** If you have Xcode installed, you will have Apple Clang, which should be sufficient for Koinos projects._

```console
$ brew install cmake clang
```
> _**Note:** If you opt to not use Xcode or its compiler, you may install Clang using brew._

#### Debian/Ubuntu

```console
$ sudo apt install build-essentials libgmp cmake
```

### Building projects

For this example we will use the [Koinos Chain](https://github.com/koinos/koinos-chain) microservice. Let's begin by cloning the repository.

```console
$ git clone --recursive https://github.com/koinos/koinos-chain.git
```

> _Koinos makes heavy use of git submodules, so we recommend using `--recursive` when cloning a repository._

Now let's generate the project. One may opt to create Unix Makefiles, Xcode, or another project type that is supported by CMake (the default project is Unix Makefiles).

You may also choose to build Debug or Release files.

Below find some common CMake incantations.

```console
# Unix Makefile (Release mode)
$ mkdir build
$ cd build
$ cmake -DCMAKE_BUILD_TYPE=Release ..
$ make -j
```

```console
# Unix Makefile (Debug mode)
$ mkdir build
$ cd build
$ cmake -DCMAKE_BUILD_TYPE=Debug ..
$ make -j
```

```console
# Xcode project
$ mkdir build
$ cd build
$ cmake -GXcode ..
$ open koinos_chain.xcodeproj
```

### Running unit tests

Koinos C++ projects use a combination of Boost test and CTest for unit testing. Tests are written in standard Boost test format while CTest allows for running tests in parallel.

After compilation, one may navigate to the `tests/` directory and invoke `ctest` to execute test suites.

```console
# Running the test suite concurrently
$ cd build/tests
$ ctest -j
Test project /Users/sgerbino/Projects/koinos-chain/build/tests
      Start  1: koinos_tests-controller_tests/submission_tests
 1/26 Test  #1: koinos_tests-controller_tests/submission_tests .............   Passed    1.23 sec
      Start  2: koinos_tests-controller_tests/block_irreversibility
 2/26 Test  #2: koinos_tests-controller_tests/block_irreversibility ........   Passed    1.10 sec
      Start  3: koinos_tests-controller_tests/fork_heads
 3/26 Test  #3: koinos_tests-controller_tests/fork_heads ...................   Passed    1.13 sec
      Start  4: koinos_tests-controller_tests/read_contract_tests
 4/26 Test  #4: koinos_tests-controller_tests/read_contract_tests ..........   Passed    1.07 sec
      Start  5: koinos_tests-controller_tests/transaction_reversion_test
 5/26 Test  #5: koinos_tests-controller_tests/transaction_reversion_test ...   Passed    1.09 sec
      Start  6: koinos_tests-statedb_tests/basic_test
 6/26 Test  #6: koinos_tests-statedb_tests/basic_test ......................   Passed    1.04 sec
      Start  7: koinos_tests-statedb_tests/fork_tests
 7/26 Test  #7: koinos_tests-statedb_tests/fork_tests ......................   Passed    1.05 sec
      Start  8: koinos_tests-statedb_tests/merge_iterator
 8/26 Test  #8: koinos_tests-statedb_tests/merge_iterator ..................   Passed    1.10 sec
      Start  9: koinos_tests-statedb_tests/reset_test
 9/26 Test  #9: koinos_tests-statedb_tests/reset_test ......................   Passed    1.08 sec
      Start 10: koinos_tests-statedb_tests/anonymous_node_test
10/26 Test #10: koinos_tests-statedb_tests/anonymous_node_test .............   Passed    1.03 sec
      Start 11: koinos_tests-thunk_tests/db_crud
11/26 Test #11: koinos_tests-thunk_tests/db_crud ...........................   Passed    1.05 sec
      Start 12: koinos_tests-thunk_tests/contract_tests
12/26 Test #12: koinos_tests-thunk_tests/contract_tests ....................   Passed    1.06 sec
      Start 13: koinos_tests-thunk_tests/override_tests
13/26 Test #13: koinos_tests-thunk_tests/override_tests ....................   Passed    1.04 sec
      Start 14: koinos_tests-thunk_tests/thunk_test
14/26 Test #14: koinos_tests-thunk_tests/thunk_test ........................   Passed    1.03 sec
      Start 15: koinos_tests-thunk_tests/system_call_test
15/26 Test #15: koinos_tests-thunk_tests/system_call_test ..................   Passed    1.05 sec
      Start 16: koinos_tests-thunk_tests/chain_thunks_test
16/26 Test #16: koinos_tests-thunk_tests/chain_thunks_test .................   Passed    1.05 sec
      Start 17: koinos_tests-thunk_tests/hash_thunk_test
17/26 Test #17: koinos_tests-thunk_tests/hash_thunk_test ...................   Passed    1.05 sec
      Start 18: koinos_tests-thunk_tests/privileged_calls
18/26 Test #18: koinos_tests-thunk_tests/privileged_calls ..................   Passed    1.06 sec
      Start 19: koinos_tests-thunk_tests/last_irreversible_block_test
19/26 Test #19: koinos_tests-thunk_tests/last_irreversible_block_test ......   Passed    1.05 sec
      Start 20: koinos_tests-thunk_tests/stack_tests
20/26 Test #20: koinos_tests-thunk_tests/stack_tests .......................   Passed    1.04 sec
      Start 21: koinos_tests-thunk_tests/require_authority
21/26 Test #21: koinos_tests-thunk_tests/require_authority .................   Passed    1.04 sec
      Start 22: koinos_tests-thunk_tests/transaction_nonce_test
22/26 Test #22: koinos_tests-thunk_tests/transaction_nonce_test ............   Passed    1.06 sec
      Start 23: koinos_tests-thunk_tests/get_contract_id_test
23/26 Test #23: koinos_tests-thunk_tests/get_contract_id_test ..............   Passed    1.05 sec
      Start 24: koinos_tests-thunk_tests/token_tests
24/26 Test #24: koinos_tests-thunk_tests/token_tests .......................   Passed    1.17 sec
      Start 25: koinos_tests-thunk_tests/get_head_block_time
25/26 Test #25: koinos_tests-thunk_tests/get_head_block_time ...............   Passed    1.05 sec
      Start 26: koinos_tests-thunk_tests/tick_limit
26/26 Test #26: koinos_tests-thunk_tests/tick_limit ........................   Passed    1.12 sec

100% tests passed, 0 tests failed out of 26

Total Test time (real) =  27.92 sec
```

It may be useful to re-run a particular test and test suite during iterative development. To achieve this we can invoke individual tests.

```console
$ ./koinos_tests -t statedb_tests/basic_test -l message
Running 1 test case...
Creating book
Modifying book
Erasing book

*** No errors detected
```

It may be useful to start a test but have it wait for the debugger to be attached. Boost provides this feature, you can leverage it by adding `--wait_for_debugger` to the test binary invocation.

```console
./koinos_tests -t statedb_tests/basic_test -l message --wait_for_debugger
Press any key to continue...

Continuing...
Running 1 test case...
Creating book
Modifying book
Erasing book

*** No errors detected
```

## Golang projects

Koinos projects using Golang leverage the built-in language facilities where possible. Retrieving dependencies and version management is handled by the language itself. Koinos projects require Golang v1.16 or better.

### Building projects

For this example we will use the [Koinos Block Store](https://github.com/koinos/koinos-block-store) microservice. Let's begin by cloning the repository.

```console
$ git clone --recursive https://github.com/koinos/koinos-block-store.git
```

> _**Note:** Koinos makes heavy use of git submodules, so we recommend using `--recursive` when cloning a repository._

Now that we have the code, let's grab all the necessary dependencies of the project.

```console
$ go get ./...
```

Keeping with our `build/` convention, we can compile the Golang binary.

```console
$ mkdir build
$ go build -o build/koinos_block_store cmd/koinos-block-store/main.go
```

### Running unit tests

Because Golang provides us with built-in unit test facilities, running tests is a simple invocation.

```console
$ go test -v ./...
?   	github.com/koinos/koinos-block-store/cmd/koinos-block-store	[no test files]
=== RUN   TestBadgerBackendBasic
badger 2021/07/15 16:14:05 INFO: All 0 tables opened in 0s
badger 2021/07/15 16:14:05 INFO: DropAll called. Blocking writes...
badger 2021/07/15 16:14:05 INFO: Writes flushed. Stopping compactions now...
badger 2021/07/15 16:14:05 INFO: Deleted 0 SSTables. Now deleting value logs...
badger 2021/07/15 16:14:05 INFO: Value logs deleted. Creating value log file: 0
badger 2021/07/15 16:14:05 INFO: Deleted 1 value log files. DropAll done.
badger 2021/07/15 16:14:05 INFO: Resuming writes
badger 2021/07/15 16:14:05 INFO: Got compaction priority: {level:0 score:1.73 dropPrefixes:[]}
--- PASS: TestBadgerBackendBasic (0.04s)
=== RUN   TestMapBackendBasic
--- PASS: TestMapBackendBasic (0.00s)
=== RUN   TestHandleReservedRequest
badger 2021/07/15 16:14:05 INFO: All 0 tables opened in 0s
badger 2021/07/15 16:14:05 INFO: Got compaction priority: {level:0 score:1.73 dropPrefixes:[]}
--- PASS: TestHandleReservedRequest (0.06s)
=== RUN   TestGetPreviousHeights
--- PASS: TestGetPreviousHeights (0.00s)
=== RUN   TestAddBlocks
badger 2021/07/15 16:14:05 INFO: All 0 tables opened in 0s
badger 2021/07/15 16:14:05 DEBUG: Storing value log head: {Fid:0 Len:43 Offset:18776}
badger 2021/07/15 16:14:05 INFO: Got compaction priority: {level:0 score:1.73 dropPrefixes:[]}
badger 2021/07/15 16:14:05 INFO: Running for level: 0
badger 2021/07/15 16:14:05 DEBUG: LOG Compact. Added 21 keys. Skipped 41 keys. Iteration took: 194.809µs
badger 2021/07/15 16:14:05 DEBUG: Discard stats: map[0:10893]
badger 2021/07/15 16:14:05 INFO: LOG Compact 0->1, del 1 tables, add 1 tables, took 17.488282ms
badger 2021/07/15 16:14:05 INFO: Compaction for level: 0 DONE
badger 2021/07/15 16:14:05 INFO: Force compaction on level 0 done
badger 2021/07/15 16:14:05 INFO: All 0 tables opened in 0s
badger 2021/07/15 16:14:06 DEBUG: Storing value log head: {Fid:0 Len:43 Offset:19054}
badger 2021/07/15 16:14:06 INFO: Got compaction priority: {level:0 score:1.73 dropPrefixes:[]}
badger 2021/07/15 16:14:06 INFO: Running for level: 0
badger 2021/07/15 16:14:06 DEBUG: LOG Compact. Added 22 keys. Skipped 41 keys. Iteration took: 202.153µs
badger 2021/07/15 16:14:06 DEBUG: Discard stats: map[0:10893]
badger 2021/07/15 16:14:06 INFO: LOG Compact 0->1, del 1 tables, add 1 tables, took 13.421024ms
badger 2021/07/15 16:14:06 INFO: Compaction for level: 0 DONE
badger 2021/07/15 16:14:06 INFO: Force compaction on level 0 done
--- PASS: TestAddBlocks (0.44s)
=== RUN   TestGetBlocksByID
--- PASS: TestGetBlocksByID (0.01s)
=== RUN   TestGetHighestBlock
badger 2021/07/15 16:14:06 INFO: All 0 tables opened in 0s
--- PASS: TestGetHighestBlock (0.03s)
=== RUN   TestInternalError
--- PASS: TestInternalError (0.00s)
PASS
ok  	github.com/koinos/koinos-block-store/internal/bstore	0.955s
```
