// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract BI{
    
    address payable contrato = payable(0x894fD20D8857509960d87480fDbce0515D5aF209);

    function newpresident()public payable {
        address(contrato).call{value:msg.value}("");
    } 



}