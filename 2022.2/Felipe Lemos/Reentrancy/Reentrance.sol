// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract Reentrance {

  mapping(address => uint) public balances;

  constructor () payable {}

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      require(result, "Failed to send eth");
      unchecked {
        balances[msg.sender] -= _amount;
      }
    }
  }
}
