// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {
    address public admin;

    // landAddress => owner
    mapping(string => string) private _landOwners;

    event NewLandOwner(string landAddress, string owner);
    event ChangedLandOwner(string landAddress, string oldOwner, string newOwner);

    error ExistingLandOwner(string landAddress);
    error NoLandOwner();

    constructor(address admin_) {
        admin = admin_;
    }

    function assignOwnership(string memory landAddress, string memory owner) public returns (bool) {
        if (bytes(_landOwners[landAddress]).length != 0) {
            revert ExistingLandOwner(landAddress);
        }
        _landOwners[landAddress] = owner;
        emit NewLandOwner(landAddress, owner);
        return true;
    }

    function changeOwnership(string memory landAddress, string memory newOwner) public returns (bool) {
        string memory oldOwner = _landOwners[landAddress];
        if (bytes(oldOwner).length == 0) {
            revert NoLandOwner();
        }
        _landOwners[landAddress] = newOwner;
        emit ChangedLandOwner(landAddress, oldOwner, newOwner);
        return true;
    }

    function landOwner(string memory landAddress) public view returns (string memory) {
        return _landOwners[landAddress];
    }
}