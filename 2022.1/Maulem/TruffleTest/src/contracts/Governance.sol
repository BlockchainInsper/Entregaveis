// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VoteCoin is ERC20 {
    constructor() ERC20("VoteCoin", "VC") {
        _mint(msg.sender,  10);
    }

    // Funcão a ser removida em um contrato de verdade
    function getTokensForTest() public {
        require(balanceOf(msg.sender) == 0, "You already got coins to test!");
        _mint(msg.sender,  10);
    }
    
    function getAddress() public view returns(ERC20) {
        return this;
    }
}

contract TokenGovernance {
    ERC20 _token;
    address private owner;
    uint256 public votersCounter;
    uint256 public tokenCounter;
    mapping(address => bool) whoVoted;
    bool private _finalized;
    bool private _teste;

    constructor(ERC20 token) {
        _token = token;
        votersCounter = 0;
        tokenCounter = 0;
        owner = msg.sender;
    }

    function vote() public {
        require(!_finalized, "Pool already ended!");
        require(!whoVoted[msg.sender], "You already voted!");
        whoVoted[msg.sender] = true;
        votersCounter++;
        tokenCounter += _token.balanceOf(msg.sender);
    }

    function endVote() public {
        require(owner == msg.sender, "You're not the owner!");
        require(!_finalized, "Pool already ended!");
        require(votersCounter > 2, "You need more people to vote!");
        require(tokenCounter > 5, "You need more Tokens in the pool!");
        _finalized = true;
    }
    
    function getStatus() public view returns(bool) {
        return _finalized;
    }

    function getVoters() public view returns(uint256) {
        return votersCounter;
    }

    function getTokens() public view returns(uint256) {
        return tokenCounter;
    }

    function hasVoted(address acc) public view returns(bool) {
        return whoVoted[acc];
    }
}