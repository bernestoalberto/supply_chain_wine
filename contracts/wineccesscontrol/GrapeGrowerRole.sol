pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FarmerRole' to manage this role - add, remove, check
contract GrapeGrowerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event grapeGrowerAdded(address indexed account);
  event grapeGrowerRemoved(address indexed account);

  // Define a struct 'grapeGrowers' by inheriting from 'Roles' library, struct Role
  Roles.Role private grapeGrowers;

  // In the constructor make the address that deploys this contract the 1st farmer
  constructor() public {
    _addGrapeGrow(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyGrapeGrower() {
    require(isGrapeGrower(msg.sender));
    _;
  }

  // Define a function 'isGrapeGrower' to check this role
  function isGrapeGrower(address account) public view returns (bool) {
    return grapeGrowers.has(account);
  }

  // Define a function 'addGrapeGrower' that adds this role
  function addGrapeGrower(address account) public onlyGrapeGrower {
    _addGrapeGrow(account);
  }

  // Define a function 'renounceGrapeGrower' to renounce this role
  function renounceGrapeGrower() public {
    _removeGrapeGrower(msg.sender);
  }

  // Define an internal function '_addGrapeGrow' to add this role, called by 'addGrapeGrower'
  function _addGrapeGrow(address account) internal {
    grapeGrowers.add(account);
    emit grapeGrowerAdded(account);
  }

  // Define an internal function '_removeGrapeGrower' to remove this role, called by 'removeFarmer'
  function _removeGrapeGrower(address account) internal {
    grapeGrowers.remove(account);
    emit grapeGrowerAdded(account);
  }
}