// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Dictator {
    address addr;
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function setDictator(address dictator) public {
        require(msg.sender == owner);
        addr = dictator;
    }

    function Monarchy() public payable {
        require(msg.sender == owner);
        address payable dest = payable(addr);
        (bool sent, ) = dest.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    fallback() payable external {}
    receive() payable external {}
    
}

// 0x3E000327eCC7BF842f95281E3a4263b66dB834D5

