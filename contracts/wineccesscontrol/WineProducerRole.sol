pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FarmerRole' to manage this role - add, remove, check
contract WineProducerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event WineProducerAdded(address indexed account);
  event WineProducerRemoved(address indexed account);

  // Define a struct 'wineProducers' by inheriting from 'Roles' library, struct Role
  Roles.Role private wineProducers;

  // In the constructor make the address that deploys this contract the 1st farmer
  constructor() public {
    _addWineProducer(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyWineProducer() {
    require(isWineProducer(msg.sender));
    _;
  }

  // Define a function 'isWineProducer' to check this role
  function isWineProducer(address account) public view returns (bool) {
    return wineProducers.has(account);
  }

  // Define a function 'addWineProducer' that adds this role
  function addWineProducer(address account) public onlyWineProducer {
    _addWineProducer(account);
  }

  // Define a function 'renounceFarmer' to renounce this role
  function renounceFarmer() public {
    _removeWineProducer(msg.sender);
  }

  // Define an internal function '_addWineProducer' to add this role, called by 'addWineProducer'
  function _addWineProducer(address account) internal {
    wineProducers.add(account);
    emit WineProducerAdded(account);
  }

  // Define an internal function '_removeWineProducer' to remove this role, called by 'removeFarmer'
  function _removeWineProducer(address account) internal {
    wineProducers.remove(account);
    emit WineProducerRemoved(account);
  }
}