// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Coin is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        address initialAccount,
        uint256 initialBalance
    ) payable ERC20(name, symbol) {
        _mint(initialAccount, initialBalance);
    }
}

contract TokenGovernance {

    ERC20 _token;
    uint256 public votersCounter;
    uint256 public tokenCounter;
    mapping(address => bool) whoVoted;

    constructor(ERC20 tokenCoin) {
        _token = tokenCoin;
    }

    function vote() public {
        require(!whoVoted[msg.sender]);
        whoVoted[msg.sender] = true;
        votersCounter++;
        tokenCounter += _token.balanceOf(msg.sender);
    }

    function endVote() public view returns(bool) {
        require(votersCounter > 2);
        require(tokenCounter > 5);
        return true;
    }
}