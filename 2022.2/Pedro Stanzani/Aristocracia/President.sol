// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract President {
    address ad;
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    function setAddress(address _ad) public {
        require(msg.sender == _owner);
        ad = _ad;
    }

    function claimPresidency() public payable {
        require(msg.sender == _owner);
        address payable _to = payable(ad);
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}