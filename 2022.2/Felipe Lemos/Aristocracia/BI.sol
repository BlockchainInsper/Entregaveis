// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BI {

  address payable public presidente;
  uint public premio;

  constructor() payable {
    presidente = payable(msg.sender);
    premio = msg.value;
  }

  receive() external payable {
    require(msg.value > premio);
    
    (bool sent, ) = presidente.call{value: msg.value}("");
    require(sent, "Failed to send Ether");

    presidente = payable(msg.sender);
    premio = msg.value;
  }
}