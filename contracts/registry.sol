// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {
    address public owner;
    
    // Mapping to track land ownership: landAddress => owner
    mapping(string => address) public landOwners;
    
    // Custom error for when caller is not the land owner
    error NoLandOwner();
    
    constructor() {
        owner = msg.sender; // Contract deployer is the admin
    }
    
    // Register new land (only admin can do this)
    function registerLand(string memory landAddress, address initialOwner) public {
        require(msg.sender == owner, "Only admin can register land");
        landOwners[landAddress] = initialOwner;
    }
    
    // Change ownership of land
    function changeOwnership(string memory landAddress, string memory newOwnerName) public {
        // Check if the caller is the current owner of the land
        if (landOwners[landAddress] != msg.sender) {
            revert NoLandOwner();
        }
        
        // Since you want to store the new owner as a string name rather than an address,
        // you'll need an additional mapping or storage mechanism
        // For this example, we'll emit an event that logs the change
        emit OwnershipChanged(landAddress, msg.sender, newOwnerName);
        
        // If you want to update actual ownership, you would need to convert newOwnerName to an address
        // or modify your data structure to accommodate string representations of owners
    }
    
    // Event to log ownership changes
    event OwnershipChanged(string landAddress, address previousOwner, string newOwnerName);
}