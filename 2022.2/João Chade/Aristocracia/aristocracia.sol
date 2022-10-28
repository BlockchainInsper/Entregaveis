// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Aristocracia {

    address addr;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner);
        addr = newOwner;
    }

    function becomeOwner() payable public {
        (bool sent, ) = addr.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function getOwner() public view returns(address) {
        return addr;
    }
}