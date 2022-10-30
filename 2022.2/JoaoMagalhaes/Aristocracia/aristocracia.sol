// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Presidente {
    address ad;
    address private presidente;

    constructor() {
        presidente = msg.sender;
    }

    function endereco(address _ad) public {
        require(msg.sender == presidente);
        ad = _ad;
    }

    function virePresidente() public payable {
        require(msg.sender == presidente);
        address payable _to = payable(ad);
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

        presidente = payable(msg.sender);
    }
    
  /* // reverts anytime it receives ether, thus cancelling out the change of the president
  fallback() external payable {
    revert();
  } */

//0x1640702CcFDfDB1eE0099a6Bad19EA3938d68069

}
