// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Aristocracia {
    address add;
    address private own;

    constructor() {
        own = msg.sender;
    }

    function setAddress(address newAd) public {
        require(msg.sender == own);
        add = newAd;
    }

    function claimPresidency() public payable {
        require(msg.sender == own);
        address payable _to = payable(add);
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// 0xE6487D6b9aD94967a5469d1Ce54C7560d47FAa96