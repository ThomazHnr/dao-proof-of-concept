# Decentralized Autonomous Organization for Circular Economy: A proof of concept in the e-waste recycling process

## What is this repository

This repository serves the purpose of storing the source code of the smart contracts developed for the article.

## How to replicate the proof of concept

The architecture of this proof of concept (PoC) was developed and tested using the following:

- [**Ethereum**](https://ethereum.org/) as the blockchain protocol;
- [**Solidity**](https://www.soliditylang.org/) as the programming language in the 0.8.19 compiler version;
- [**Remix Desktop**](https://remix.live/desktop) as the Integrated Development Environment (IDE) in version 0.38.1;
- [**Ganache**](https://archive.trufflesuite.com/ganache/) as the emulator for a local instance of the Ethereum network.

To replicate the experimental results, the private Ethereum instance must be configured according to the following parameters:

- Account initial balance: 100 ether;
- Automine feature: Enabled;
- Gas limit: 2,100,000 gas;
- Gas price: 57 gwei;
- Hardfork: Merge
- Host’s IP: 127.0.0.1 (localhost);
- Network ID: 5777;
- Port number: 7545;
- Accounts generated: 1.

The PoC utilizes a single Ethereum account, and integers are used as identifiers to simplify the validation of core computational and storage features. The contract `DAO_PoC.sol` acts as a monolith to centralize logic for validation. If desired, each smart contract is able to be deployed and tested separately. These are the steps to replicate the execution of the PoC:

1. Compile the `DAO_PoC.sol` contract;
2. Deploy the contract to the local Ganache network via Remix Desktop;
3. Execute the run function within the deployed contract to initiate the simulation script.
