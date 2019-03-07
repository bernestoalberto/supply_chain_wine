# UML
* Secuence Diagram
* Activity Diagram
* State Diagram
* Class Diagram

# Project Details
``DApp supply chain solution backed by the Ethereum platform. Architecting smart contracts that manage specific user permission controls as well as contracts that track and verify a wine's authenticity``
## Libraries
* Infura
* Metamask 6.1.0
* Web3 1.0.0
* IPFS-http-client 29.1.1
* openzeppelin-solidity 2.0.0
* Ethereum 6.0.3
* Node 11.10.1
* Solidity
* React 16.8.3
* Ganache-cli  6.23
* Truffle 4.1.15

## IPFS

``The Dapp will take a file as input from a user and upload it to the IPFS by invoking an Ethereum contract. The hash of the file will be stored on Ethereum.``

The process we’ll go through:

* Take file as an input
* Convert file to buffer
* Upload buffer to IPFS
* Store hash of file returned by IPFS
* Get user’s Metamask Ethereum address
* User confirms transaction to Ethereum via Metamask
* IPFS hash is written on Ethereum

## Install 
Clone this repository:

`git clone https://github.com/bernestoalberto/supply_chain_wine.git`

Change directory to supply_chain_wine folder and install all requisite npm packages (as listed in package.json):

`cd supply_chain_wine`
`npm install`

Launch Ganache:

`ganache-cli -m "crater close lunar fitness uphold glue morning resemble suspect cigar front roast"`

Compile smart contracts:

`truffle compile`

Migrate smart contracts to the locally running blockchain, ganache-cli:

`truffle migrate --reset --network rinkeby`

## Deploy Smarts Contract 
 Deploying Migrations...
  ... 0x86ec8f3ff43d083bcb4ab0bb30716430b222a160ec54e497aad09b972bf8f0a0
  Migrations: 0x5627ea96d816299a47b9804f95b4d5390edc4a9c
Saving successful migration to network...
  ... 0x797ac9fde7148f6926606e223058a10571d22bbf10fffbea072b3749de2d83e2
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying GrapeGrowerRole...
  ... 0xfcfdc999ee7b1989d54a9ea42a2a967382cad39b3cbf1fb595a05b1ace685e06
* GrapeGrowerRole: 0x7cab926635ac611143337cf44ec713ab24e082db
  Deploying BulkDistributorRole...
  ... 0x59ea2db4529429686b93952f261509459648947e09d64c2793c288bdd0b76140
*  BulkDistributorRole: 0x946f116fa73a92a1da30e51f2a13b675f5df82de
  Deploying WineProducerRole...
  ... 0x1cbed93a5f6932754f0f7545aeca4a15c9c9580aecd6f1783e9d5abb6c30ecc9
*  WineProducerRole: 0x3e477f0d90e822b23c876d3a91079041007d70e0
  Deploying FillerPackerRole...
  ... 0x4cd42d433d333a051a3ec81e21efee05be483ea75c5784219db19a9451ee568e
*  FillerPackerRole: 0xe57a1c5b89390800b1dd9bd6cf061a4074b1eaf0
  Deploying TransitCellarRole...
  ... 0x683be76ae95ff8cfe26dd6041539b1efc247ce0c98ca2bdcbe81a354a9b31a00
*  TransitCellarRole: 0x1178d0d6fbe9036789cc12d14a9a6c5a0db0eca6
  Deploying DistributorRole...
  ... 0xb48ac172598f777f06f4e0f6fa920a43109820fe44c129560fbaa0e5fad1d5af
*  DistributorRole: 0x06bd0ffb0053c36f67451988be9f7df1c6d32e32
  Deploying RetailerRole...
  ... 0x98d58f21806011687a2a0711ddeccf67d620f148240572eea5ddd0249e9c66e3
*  RetailerRole: 0x154394f6afaa850a0096c6cc88d931156cc6d2c0
  Deploying ConsumerRole...
  ... 0x067e53d5c76a8a01e26f8152be8da2d689daad678b97242156b6628e0cfa45db
*  ConsumerRole: 0xe42c9eb5ea0acbc66dc8f7ad4014722351d990dd
  Deploying SupplyChain...
  ... 0x190f05efa9c61848872bfb63bdc8c0e56681cb453ffb42876c3c768945d83727
*  SupplyChain: 0xaf697cf3b3d7621df2f5babf88f10acafaba3363
Saving successful migration to network...
  ... 0x6466e71d779d5b9c9c8fde023ec6fb9161f4dd825ab98924a207249a08c8b6b2
Saving artifacts...

Test smart contracts:

`truffle test`



Launch the DApp:

`npm run dev`