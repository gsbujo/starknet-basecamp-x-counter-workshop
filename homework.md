# Content
This file contains information for completing the various steps of the workshop.


## Step 1
From the terminal, initialize the project with `scarb`, naming the package `workshop`.
```
scarb init --name workshop
```
It creates Scarb.toml and src/lib.cairo
The initial Scarb.toml content is :
```
[package]
name = "workshop"
version = "0.1.0"
edition = "2024_07"

# See more keys and their definitions at https://docs.swmansion.com/scarb/docs/reference/manifest.html

[dependencies]

[dev-dependencies]
cairo_test = "2.8.0"
```

`scarb build` creates the target folder.
````
target
├── CACHEDIR.TAG
└── dev
    ├── workshop.starknet_artifacts.json
    └── workshop_counter_contract.contract_class.json
````

`scarb clean` deletes the target folder.


## Step 2
### Note :
Without test script defined Scarb.toml, the output of scarb test is 
````
scarb test
     Running cairo-test workshop
   Compiling test(workshop_unittest) workshop v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
   Compiling test(workshop_tests) workshop_tests v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
    Finished release target(s) in 5 seconds
testing workshop ...
running 1 test
test workshop_tests::test_step::test_snforge ... ok (gas usage est.: 22440)
test result: ok. 1 passed; 0 failed; 0 ignored; 0 filtered out;

running 0 tests
test result: ok. 0 passed; 0 failed; 0 ignored; 0 filtered out;
````

With test script defined Scarb.toml, the output of scarb test is now that we need
````
scarb test
     Running test workshop (snforge test)
   Compiling workshop v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
    Finished release target(s) in 2 seconds


Collected 1 test(s) from workshop package
Running 0 test(s) from src/
Running 1 test(s) from tests/
[PASS] tests::test_step::test_snforge (gas: ~1)
Tests: 1 passed, 0 failed, 0 skipped, 0 ignored, 0 filtered out
````

#### without casm=true
```
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % scarb build
   Compiling workshop v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
    Finished release target(s) in 2 seconds
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % tree target
target
├── CACHEDIR.TAG
└── dev
    ├── workshop.starknet_artifacts.json
    └── workshop_counter_contract.contract_class.json

2 directories, 3 files
```

#### with casm=true
```
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % scarb build
   Compiling workshop v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
    Finished release target(s) in 2 seconds
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % tree target
target
├── CACHEDIR.TAG
└── dev
    ├── workshop.starknet_artifacts.json
    ├── workshop_counter_contract.compiled_contract_class.json
    └── workshop_counter_contract.contract_class.json

2 directories, 4 files
```

Finally with scarb test
```
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % scarb test 
     Running test workshop (snforge test)
   Compiling workshop v0.1.0 (/Users/gsbujo/projects/starknet/basecampx/starknet-basecamp-x-counter-workshop/Scarb.toml)
    Finished release target(s) in 2 seconds


Collected 1 test(s) from workshop package
Running 0 test(s) from src/
Running 1 test(s) from tests/
[PASS] tests::test_step::test_snforge (gas: ~1)
Tests: 1 passed, 0 failed, 0 skipped, 0 ignored, 0 filtered out
gsbujo@macbook-air starknet-basecamp-x-counter-workshop % tree target
target
├── CACHEDIR.TAG
└── dev
    ├── snforge
    │   └── workshop.snforge_sierra.json
    ├── workshop.starknet_artifacts.json
    ├── workshop_counter_contract.compiled_contract_class.json
    └── workshop_counter_contract.contract_class.json

3 directories, 5 files
```