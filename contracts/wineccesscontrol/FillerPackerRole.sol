pragma solidity ^0.4.24;

// Import the library 'Roles'
import "./Roles.sol";

// Define a contract 'FillerPackerRole' to manage this role - add, remove, check
contract FillerPackerRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event FillerPackerAdded(address indexed account);
  event FillerPackerRemoved(address indexed account);

  // Define a struct 'FillerPackers' by inheriting from 'Roles' library, struct Role
  Roles.Role private fillerPackers;

  // In the constructor make the address that deploys this contract the 1st FillerPacker
  constructor() public {
    _addFillerPacker(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyFillerPacker() {
    require(isFillerPacker(msg.sender));
    _;
  }

  // Define a function 'isFillerPacker' to check this role
  function isFillerPacker(address account) public view returns (bool) {
    return fillerPackers.has(account);
  }

  // Define a function 'addFillerPacker' that adds this role
  function addFillerPacker(address account) public onlyFillerPacker {
    _addFillerPacker(account);
  }

  // Define a function 'renounceFillerPacker' to renounce this role
  function renounceFillerPacker() public {
    _removeFillerPacker(msg.sender);
  }

  // Define an internal function '_addFillerPacker' to add this role, called by 'addFillerPacker'
  function _addFillerPacker(address account) internal {
    fillerPackers.add(account);
    emit FillerPackerAdded(account);
  }

  // Define an internal function '_removeFillerPacker' to remove this role, called by 'removeFillerPacker'
  function _removeFillerPacker(address account) internal {
    fillerPackers.remove(account);
    emit FillerPackerRemoved(account);
  }
}