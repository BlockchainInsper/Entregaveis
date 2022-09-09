// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vazio {
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function steal(address payable endereco) public payable {
        selfdestruct(endereco);
    }

    receive() external payable {}
}