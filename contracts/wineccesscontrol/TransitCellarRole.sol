pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'TransitCellarRole' to manage this role - add, remove, check
contract TransitCellarRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event TransitCellarRoleAdded(address indexed account);
  event TransitCellarRemoved(address indexed account);

  // Define a struct 'transitCellars' by inheriting from 'Roles' library, struct Role
  Roles.Role private transitCellars;

  // In the constructor make the address that deploys this contract the 1st farmer
  constructor() public {
    _addTransitCellar(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyTransitCellar() {
    require(isTransitCellar(msg.sender));
    _;
  }

  // Define a function 'isTransitCellar' to check this role
  function isTransitCellar(address account) public view returns (bool) {
    return transitCellars.has(account);
  }

  // Define a function 'addTransitCellar' that adds this role
  function addTransitCellar(address account) public onlyTransitCellar {
    _addTransitCellar(account);
  }

  // Define a function 'renounceTransitCellars' to renounce this role
  function renounceTransitCellars() public {
    _removeTransitCellar(msg.sender);
  }

  // Define an internal function '_addTransitCellar' to add this role, called by 'addTransitCellar'
  function _addTransitCellar(address account) internal {
    transitCellars.add(account);
    emit TransitCellarRoleAdded(account);
  }

  // Define an internal function '_removeTransitCellars' to remove this role, called by 'removeFarmer'
  function _removeTransitCellar(address account) internal {
    transitCellars.remove(account);
    emit TransitCellarRemoved(account);
  }
}