// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract givemoney{

    function pay() public payable{

    }
    function balance()public view returns(uint){
        return address(this).balance;

    }
    function destruct() public {
        selfdestruct(0x95bB3547C28B231879d6b0DC20f6c9039B850844);
        }
}
