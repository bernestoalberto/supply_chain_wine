pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FarmerRole' to manage this role - add, remove, check
contract BulkDistrubutorRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event bulkDistrubutorAdded(address indexed account);
  event bulkDistrubutorAdded(address indexed account);

  // Define a struct 'bulkDistrubutors' by inheriting from 'Roles' library, struct Role
  Roles.Role private bulkDistrubutors;

  // In the constructor make the address that deploys this contract the 1st bulkDistrubutor
  constructor() public {
    _addbulkDistrubutor(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyBulkDistrubutor() {
    require(isBulkDistrubutor(msg.sender));
    _;
  }

  // Define a function 'isBulkDistrubutor' to check this role
  function isBulkDistrubutor(address account) public view returns (bool) {
    return bulkDistrubutors.has(account);
  }

  // Define a function 'addBulkDistrubutor' that adds this role
  function addBulkDistrubutor(address account) public onlyBulkDistrubutor {
    _addbulkDistrubutor(account);
  }

  // Define a function 'renounceBulkDistributor' to renounce this role
  function renounceBulkDistributor() public {
    _removeBulkDistributor(msg.sender);
  }

  // Define an internal function '_addbulkDistrubutor' to add this role, called by 'addBulkDistrubutor'
  function _addbulkDistrubutor(address account) internal {
    bulkDistrubutors.add(account);
    emit bulkDistrubutorAdded(account);
  }

  // Define an internal function '_removeBulkDistributor' to remove this role, called by 'removeFarmer'
  function _removeBulkDistributor(address account) internal {
    bulkDistrubutors.remove(account);
    emit bulkDistrubutorAdded(account);
  }
}