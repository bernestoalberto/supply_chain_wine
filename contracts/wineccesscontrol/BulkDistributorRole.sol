pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FarmerRole' to manage this role - add, remove, check
contract BulkDistributorRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event bulkDistributorAdded(address indexed account);
  event bulkDistributorRemoved(address indexed account);

  // Define a struct 'bulkDistributors' by inheriting from 'Roles' library, struct Role
  Roles.Role private bulkDistributors;

  // In the constructor make the address that deploys this contract the 1st bulkDistributor
  constructor() public {
    _addbulkDistributor(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlybulkDistributor() {
    require(isbulkDistributor(msg.sender));
    _;
  }

  // Define a function 'isbulkDistributor' to check this role
  function isbulkDistributor(address account) public view returns (bool) {
    return bulkDistributors.has(account);
  }

  // Define a function 'addbulkDistributor' that adds this role
  function addbulkDistributor(address account) public onlybulkDistributor {
    _addbulkDistributor(account);
  }

  // Define a function 'renounceBulkDistributor' to renounce this role
  function renounceBulkDistributor() public {
    _removeBulkDistributor(msg.sender);
  }

  // Define an internal function '_addbulkDistributor' to add this role, called by 'addbulkDistributor'
  function _addbulkDistributor(address account) internal {
    bulkDistributors.add(account);
    emit bulkDistributorAdded(account);
  }

  // Define an internal function '_removeBulkDistributor' to remove this role, called by 'removeFarmer'
  function _removeBulkDistributor(address account) internal {
    bulkDistributors.remove(account);
    emit bulkDistributorAdded(account);
  }
}