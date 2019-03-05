// migrating the appropriate contracts
let GrapeGrowerRole = artifacts.require("./GrapeGrowerRole.sol");
let BulkDistributorRole = artifacts.require("./BulkDistributorRole.sol");
let WineProducerRole = artifacts.require("./WineProducerRole.sol");
let FillerPackerRole = artifacts.require("./FillerPackerRole.sol");
let TransitCellarRole = artifacts.require("./TransitCellarRole.sol");
let DistributorRole = artifacts.require("./DistributorRole.sol");
let RetailerRole = artifacts.require("./RetailerRole.sol");
let ConsumerRole = artifacts.require("./ConsumerRole.sol");
let SupplyChain = artifacts.require("./SupplyChain.sol");

module.exports = function(deployer) {
  deployer.deploy(GrapeGrowerRole);
  deployer.deploy(BulkDistributorRole);
  deployer.deploy(WineProducerRole);
  deployer.deploy(FillerPackerRole);
  deployer.deploy(TransitCellarRole);
  deployer.deploy(DistributorRole);
  deployer.deploy(RetailerRole);
  deployer.deploy(ConsumerRole);
  deployer.deploy(SupplyChain);
};
