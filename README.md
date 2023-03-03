![banner](https://github.com/conductiveai/playmanager/blob/main/github/banner.png?raw=true)
```
 _______  __                   __       __                                                       
|       \|  \                 |  \     /  \                                                      
| ▓▓▓▓▓▓▓\ ▓▓ ______  __    __| ▓▓\   /  ▓▓ ______  _______   ______   ______   ______   ______  
| ▓▓__/ ▓▓ ▓▓|      \|  \  |  \ ▓▓▓\ /  ▓▓▓|      \|       \ |      \ /      \ /      \ /      \ 
| ▓▓    ▓▓ ▓▓ \▓▓▓▓▓▓\ ▓▓  | ▓▓ ▓▓▓▓\  ▓▓▓▓ \▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\
| ▓▓▓▓▓▓▓| ▓▓/      ▓▓ ▓▓  | ▓▓ ▓▓\▓▓ ▓▓ ▓▓/      ▓▓ ▓▓  | ▓▓/      ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓   \▓▓
| ▓▓     | ▓▓  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ \▓▓▓| ▓▓  ▓▓▓▓▓▓▓ ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓__| ▓▓ ▓▓▓▓▓▓▓▓ ▓▓      
| ▓▓     | ▓▓\▓▓    ▓▓\▓▓    ▓▓ ▓▓  \▓ | ▓▓\▓▓    ▓▓ ▓▓  | ▓▓\▓▓    ▓▓\▓▓    ▓▓\▓▓     \ ▓▓      
 \▓▓      \▓▓ \▓▓▓▓▓▓▓_\▓▓▓▓▓▓▓\▓▓      \▓▓ \▓▓▓▓▓▓▓\▓▓   \▓▓ \▓▓▓▓▓▓▓_\▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓\▓▓      
                     |  \__| ▓▓                                      |  \__| ▓▓                  
                      \▓▓    ▓▓                                       \▓▓    ▓▓                  
                       \▓▓▓▓▓▓                                         \▓▓▓▓▓▓                   

```
# 🎮 PlayManager v1.0.0
Play Manager is the smart contract companion to [Conductive Instant Play](https://conductive.ai/instantplay).
[Conductive](https://conductive.ai) Instant Play is an SDK that enables games to intuitively persist in-game events to multiple blockchains without the overhead, integration and budget required in web3. No gas, no wallets, no contracts -- it just works.


# 📁 Directory structure
```
    .
    ├── 📁 lib (library imports)
    │   ├── 📁 forge-std (forge standard library)
    │   ├── 📁 openzeppelin-contracts (openzeppelin contract libs)
    │   └── 📁 openzeppelin-upgrades (openzeppelin upgrade libs)
    ├── 📁 out (output directory)
    ├── 📁 src
    │   └── 🤖 PlayManager.sol (smart contract)
    ├── 📁 test
    │   └── 🧪 PlayManager.t.sol (smart contract test file)
    ├── ⚙️ foundry.toml (foundry config)
    ├── ⛽ gas-profile.txt (gas used per test function)
    ├── 📝 remappings.txt (remappings for solc)
    └── ⚙️ slither.config.json (remappings for slither)
```

# 📝 Contract
Functionality is straight-forward for v1.0.0:
- 🎮 Basic game event logging
  - `createAccount(uint256 accountType)` - create a new account
  - `startSession(uint256 sessionType)` - start a new session
  - `dailyLogin(uint256 sessionType, string calldata sessionId, string calldata userId)` - log a daily login
  - ... a LOT more to come
- 🛰️ Events directly monitored by Instant Play Service backend / client API
- ✨ Upgradeable via UUPS proxy method
- ⛽ Optimized for minimal wallet gas usage
- 🔐 Secured via OpenZeppelin libraries
- ⚙️ Configurable, upgradeable and pauseable via master wallet

# 🏁 Getting started
This repository is setup to use [Foundry](https://book.getfoundry.sh/getting-started/first-steps) for development, testing and deployment. Foundry is a fast and lightweight toolchain vs. Hardhat / Brownie / etc. created by the gigachads at [Paradigm](https://paradigm.xyz/).

```
1. Download Foundry install script:

$ curl -L https://foundry.paradigm.xyz | bash

2. Install Foundry CLI

$ foundryup
```

If you have issues with the install script (like I did with `libusb`), you can install and build Foundry manually:

```
1. Install Rust

$ curl https://sh.rustup.rs -sSf | sh

2. Use crates (Rust package manager) to build and install foundry

$ cargo install --git https://github.com/foundry-rs/foundry foundry-cli anvil chisel --bins --locked
```

Next clone the repo

```
git clone https://github.com/conductiveai/playmanager.git
cd playmanager
```

# 🧪 Run tests
To run tests in the `tests` directory, run:
```
forge test
```
Should see 5 tests pass:
![image](https://github.com/conductiveai/playmanager/blob/main/github/tests.png?raw=true)

# 🏗️ Building and deploying

### Compiling

```bash
forge build
```

The build command will compile the contract and output the compiled contract to the `out` directory. The build command will also generate a `remappings.txt` file which is used by the `forge test` command to run tests.

### Flattening the contract

```bash
forge flatten --output src/PlayManager.flattened.sol src/PlayManager.sol
```

Output:

![image](https://github.com/conductiveai/playmanager/blob/main/github/flattened.png?raw=true)


The flatten command will concatenate all the imports into a single file. This is useful for running static analysis tools like Slither.

### Generating the ABI
```bash
forge inspect src/PlayManager.sol:PlayManager abi > PlayManager.abi.json
```

### Constructor
The constructors are position based, in our case it is app name and app ID. The constructor is called when the contract is deployed. The constructor is only called once, when the contract is first deployed. The constructor is not called when the contract is upgraded

```solidity
function initialize(string memory _appName, string memory _appID) initializer public {}
```
- `_appName` - name of the game
- `_appID` - project UUID of the game

### Deploying via RPC node
Deployment is done via `forge create`:
```bash
forge create --rpc-url https://mainnet.infura.io --private-key 0xd34db33fd00d src/PlayManager.sol:PlayManager --constructor-args "SuperGigaChad","3411297c-57d8-4704-8ca1-39935ebc92c9"
```

(Remember the constructor above, argument 1 is app name, argument 2 is app ID)

You can also set the deploying account private key via
```bash
export privateKey=0xd34db33fd00d
```

### Deploying via REMIX
📺 Walkthrough video coming soon


# ⛓️ Create dev testnet with Anvil
Anvil is a local testnet the comes with Foundry CLI.

### Start Anvil
```bash
forge anvil start
```
![image](https://github.com/conductiveai/playmanager/blob/main/github/anvil.png?raw=true)

Your local RPC node will be running on `http://127.0.0.1:8545`

# 🧐 Verification on Block Explorer
You can also easily verify your contract via CLI by running:
```bash
forge verify-contract --chain-id 1 --num-of-optimizations 200 --constructor-args (cast abi-encode "constructor(string,string)" "SuperGigaChad" "3411297c-57d8-4704-8ca1-39935ebc92c9" --compiler-version v0.8.0+commit.c7dfd78e 0xContractAddressHere src/PlayManager.flattened.sol:PlayManager <your-blockexplorer-key>
```

# 🌟 Upgrading the Proxy Contract

PlayManager implements the UUPSUpgradeable library from OpenZeppelin. This allows the contract to be upgraded via the function `_upgradeToAndCall(newImplementation, data);` which is called by the `upgradeToAndCall` function in the proxy contract.

You can find an [implementation of this here](https://github.com/jordaniza/OZ-Upgradeable-Foundry/blob/main/script/DeployUUPS.s.sol).

Example:
![image](https://github.com/conductiveai/playmanager/blob/main/github/upgrade.png?raw=true)


# 🔐 Security
- [Slither](https://www.alchemy.com/dapps/slither) is an [open-source contract security framework](https://github.com/crytic/slither) written in Python. It runs a suite of vulnerability detectors and prints visual information about contract detail. This is the output of running Slither on the PlayManager contract:

### Install Slither
```bash
pip3 install slither-analyzer
pip3 install solc-select
solc-select install 0.8.13
solc-select use 0.8.13
```

### Running slither
```bash
slither src/PlayManager.flattened.sol
```
Output running Slither on the PlayManager contract:
- ![image](https://github.com/conductiveai/playmanager/blob/main/github/slither.png?raw=true)


# ☑️ TODO
- [ ] Multi-party auth (client, master wallet, etc.)
- [ ] Client contract inheritance for ERC20, ERC721, and ERC1155
- [ ] SDK CRUD primitives for ERC20, ERC721, and ERC1155

# 🗃️ References
- [Foundry docs](https://book.getfoundry.sh/getting-started/first-steps)
- [Foundry tutorial](https://jamesbachini.com/foundry-tutorial/)
- [Foundry Walkthrough](https://coinsbench.com/demystifying-foundry-9d589f03730d)
- [UUPS proxies](https://blog.logrocket.com/using-uups-proxy-pattern-upgrade-smart-contracts/)