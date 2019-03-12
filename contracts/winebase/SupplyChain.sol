pragma solidity ^0.4.24;

import "../wineccesscontrol/Roles.sol";
// Define a contract 'Supplychain'
contract SupplyChain {

    using Roles for Roles.Role;
   

   Roles.Role  private rol;


  
  // Define 'owner'
  address owner;

  // Define a variable called 'upc' for Universal Product Code (UPC)
  uint  upc;

  // Define a variable called 'sku' for Stock Keeping Unit (SKU)
  uint  sku;

  // Define a public mapping 'items' that maps the UPC to an Item.
  mapping (uint => Item) items;

  // Define a public mapping 'itemsHistory' that maps the UPC to an array of TxHash, 
  // that track its journey through the supply chain -- to be sent from DApp.
  mapping (uint => string[]) itemsHistory;



  
  // Define enum 'State' with the following values:
  enum State 
  { 
    Harvested,  // 0
    Processed,  // 1
    Packed,     // 2
    ForSale,    // 3
    Sold,       // 4
    Shipped,    // 5
    Received,   // 6
    Purchased   // 7
    }

  State constant defaultState = State.Harvested;

  // Define a struct 'Item' with the following fields:
  struct Item {
    uint    sku;  // Stock Keeping Unit (SKU)
    uint    upc; // Universal Product Code (UPC), generated by the GrapeGrower, goes on the package, can be verified by the Consumer
    address ownerID;  // Metamask-Ethereum address of the current owner as the product moves through 8 stages
    address originGrapeGrowerID; // Metamask-Ethereum address of the GrapeGrower
    string  originGrapeGrowerName; // GrapeGrower Name
    string  originGrapeGrowerInformation;  // GrapeGrower Information
    string  originGrapeGrowerLatitude; // GrapeGrower Latitude
    string  originGrapeGrowerLongitude;  // GrapeGrower Longitude
    uint    productID;  // Product ID potentially a combination of upc + sku
    string  productNotes; // Product Notes
    uint    productPrice; // Product Price
    State   itemState;  // Product State as represented in the enum above
    address distributorID;  // Metamask-Ethereum address of the Distributor
    address retailerID; // Metamask-Ethereum address of the Retailer
    address consumerID; // Metamask-Ethereum address of the Consumer
  }

  // Define 8 events with the same 8 state values and accept 'upc' as input argument
  event Harvested(uint upc);
  event Processed(uint upc);
  event Packed(uint upc);
  event ForSale(uint upc);
  event Sold(uint upc);
  event Shipped(uint upc);
  event Received(uint upc);
  event Purchased(uint upc);

  // Define a modifer that checks to see if msg.sender == owner of the contract
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  // Define a modifer that verifies the Caller
  modifier verifyCaller (address _address) {
    require(msg.sender == _address); 
    _;
  }

  // Define a modifier that checks if the paid amount is sufficient to cover the price
  modifier paidEnough(uint _price) { 
    require(msg.value >= _price); 
    _;
  }
  
  // Define a modifier that checks the price and refunds the remaining balance
  modifier checkValue(uint _upc) {
    _;
    uint _price = items[_upc].productPrice;
    uint amountToReturn = msg.value - _price;
    items[_upc].consumerID.transfer(amountToReturn);
  }

  // Define a modifier that checks if an item.state of a upc is Harvested
  modifier harvested(uint _upc) {
    require(items[_upc].itemState == State.Harvested);
    _;
  }

  // Define a modifier that checks if an item.state of a upc is Processed
  modifier processed(uint _upc) {
     require(items[_upc].itemState == State.Processed);     
    _;
  }
  
  // Define a modifier that checks if an item.state of a upc is Packed
  modifier packed(uint _upc) {
require(items[_upc].itemState == State.Packed);   
    _;
  }

  // Define a modifier that checks if an item.state of a upc is ForSale
  modifier forSale(uint _upc) {
require(items[_upc].itemState == State.ForSale);   
    _;
  }

  // Define a modifier that checks if an item.state of a upc is Sold
  modifier sold(uint _upc) {
require(items[_upc].itemState == State.Sold);   
    _;
  }
  
  // Define a modifier that checks if an item.state of a upc is Shipped
  modifier shipped(uint _upc) {
require(items[_upc].itemState == State.Shipped);   
    _;
  }

  // Define a modifier that checks if an item.state of a upc is Received
  modifier received(uint _upc) {
 require(items[_upc].itemState == State.Received);   
    _;
  }

  // Define a modifier that checks if an item.state of a upc is Purchased
   modifier purchased(uint _upc) {
  require(items[_upc].itemState == State.Purchased);     
    _;
  }

  // In the constructor set 'owner' to the address that instantiated the contract
  // and set 'sku' to 1
  // and set 'upc' to 1
  constructor() public payable {
    owner = msg.sender;
    sku = 1;
    upc = 1;
  }

  // Define a function 'kill' if required
  function kill() public {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

  // Define a function 'harvestItem' that allows a GrapeGrower to mark an item 'Harvested'
  function harvestItem(uint _upc, address _originGrapeGrowerID, string _originGrapeGrowerName, string _originGrapeGrowerInformation,
   string  _originGrapeGrowerLatitude, string  _originGrapeGrowerLongitude, string  _productNotes) public 
  {
    // Add the new item as part of Harvest
    items[_upc].itemState = State.Harvested;
    // Increment sku
    sku = sku + 1;
    // Emit the appropriate event
   emit Harvested(_upc);
  }

  // Define a function 'processtItem' that allows a GrapeGrower to mark an item 'Processed'
  function processItem(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
     
  // Call modifier to verify caller of this function

  {
     require(itemsHistory[_upc]);
   verifyCaller(items[_upc].ownerID);
    // Update the appropriate fields
    items[_upc].itemState = State.Processed;
    // Emit the appropriate event
    Processed(_upc);
  }

  // Define a function 'packItem' that allows a GrapeGrower to mark an item 'Packed'
  function packItem(uint _upc) public 
  // Call modifier to check if upc has passed previous supply chain stage
 
  // Call modifier to verify caller of this function
 
  {
     require(itemsHistory[_upc]);
       verifyCaller(items[_upc].ownerID);
    // Update the appropriate fields
    items[_upc].itemState = State.Packed;
    // Emit the appropriate event
    Packed(_upc);  
  }

  // Define a function 'sellItem' that allows a GrapeGrower to mark an item 'ForSale'
  function sellItem(uint _upc, uint _price) public 
  // Call modifier to check if upc has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {

      
      require(itemsHistory[_upc]);
       verifyCaller(items[_upc].ownerID);
    // Update the appropriate fields
      forSale(_upc);
    // Emit the appropriate event
    ForSale(_upc);
  }

  // Define a function 'buyItem' that allows the disributor to mark an item 'Sold'
  // Use the above defined modifiers to check if the item is available for sale, if the buyer has paid enough, 
  // and any excess ether sent is refunded back to the buyer
  function buyItem(uint _upc) public payable 
    // Call modifier to check if upc has passed previous supply chain stage
    
    // Call modifer to check if buyer has paid enough
    
    // Call modifer to send any excess ether back to buyer
    
    {
      require(itemsHistory[_upc]);
      paidEnough(_upc);
       checkValue(_upc);

    // Update the appropriate fields - ownerID, distributorID, itemState
   itemsHistory[_upc].ownerID= items[_upc].distributorID;
    itemsHistory[_upc].distributorID = items[_upc].distributorID;
    sold(_upc);
    // Transfer money to GrapeGrower
    address _sender = items[_upc].ownerID;
    _sender.send(msg.value);
    // emit the appropriate event
    Sold(_upc);
  }

  // Define a function 'shipItem' that allows the distributor to mark an item 'Shipped'
  // Use the above modifers to check if the item is sold
  function shipItem(uint _upc) public 
    // Call modifier to check if upc has passed previous supply chain stage
    
    // Call modifier to verify caller of this function
    
    {
       require(itemsHistory[_upc]);
       verifyCaller(items[_upc].ownerID);
    // Update the appropriate fields
      shipped(_upc);
    // Emit the appropriate event
      Shipped(_upc);
  }

  // Define a function 'receiveItem' that allows the retailer to mark an item 'Received'
  // Use the above modifiers to check if the item is shipped
  function receiveItem(uint _upc) public 
    // Call modifier to check if upc has passed previous supply chain stage
    
    // Access Control List enforced by calling Smart Contract / DApp
    {
         require(itemsHistory[_upc]);
          rol.has(items[_upc].ownerID);
    // Update the appropriate fields - ownerID, retailerID, itemState
    received(_upc);
    // Emit the appropriate event
    Received(_upc);
  }

  // Define a function 'purchaseItem' that allows the consumer to mark an item 'Purchased'
  // Use the above modifiers to check if the item is received
  function purchaseItem(uint _upc) public 
    // Call modifier to check if upc has passed previous supply chain stage
    
    // Access Control List enforced by calling Smart Contract / DApp
    {
  require(itemsHistory[_upc]);
  rol.has(items[_upc].ownerID);
    // Update the appropriate fields - ownerID, consumerID, itemState
     itemsHistory[_upc].ownerID= items[_upc].consumerID;
    itemsHistory[_upc].distributorID = items[upc].distributorID;
    purchased(_upc);
    // Emit the appropriate event
    Purchased(_upc);
  }

  // Define a function 'fetchItemBufferOne' that fetches the data
  function fetchItemBufferOne(uint _upc) public view returns 
  (
  uint    itemSKU,
  uint    itemUPC,
  address ownerID,
  address originGrapeGrowerID,
  string  originGrapeGrowerName,
  string  originGrapeGrowerInformation,
  string  originGrapeGrowerLatitude,
  string  originGrapeGrowerLongitude
  ) 
  {
  // Assign values to the 8 parameters
  
    
  return 
  (
  itemSKU = 3,
  itemUPC = 3,
  ownerID = '0xaddc2954a1759bd8207ba7d3e69ecf0daa1539ff',
  originGrapeGrowerID = '0xdc196587b59a8accbab502a642ce96ae71e017e1',
  originGrapeGrowerName = 'Sauvingon',
  originGrapeGrowerInformation = 'Viva la France',
  originGrapeGrowerLatitude = '44.8378° N',
  originGrapeGrowerLongitude = '0.5792° W'
  );
  }

  // Define a function 'fetchItemBufferTwo' that fetches the data
  function fetchItemBufferTwo(uint _upc) public view returns 
  (
  uint    itemSKU,
  uint    itemUPC,
  uint    productID,
  string  productNotes,
  uint    productPrice,
  uint    itemState,
  address distributorID,
  address retailerID,
  address consumerID
  ) 
  {
    // Assign values to the 9 parameters
  
    
  return 
  (
  itemSKU = 2,
  itemUPC = 2,
  productID = '22',
  productNotes = 'Product from Spain',
  productPrice = 12.5,
  itemState = 'Packed',
  distributorID = '0xfa937f92f8a106dcac3f3d2d8930e07e540a596d',
  retailerID = '0xd69ba0709d161543fa19fa67c2e3ee95da33fb72',
  consumerID = '0x4ae0f84a7ad98e6cd3d8c11a7f4e5d9398d364e8'
  );
  }
}
