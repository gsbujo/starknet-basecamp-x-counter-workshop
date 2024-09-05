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




