// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Coin is ERC20 {
    constructor() ERC20("Teste", "TXT") {
        _mint(msg.sender,  20000000000000000000);
    }
    
    function getToken() public view returns(ERC20) {
        return this;
    }
}

contract TokenGovernance {
    ERC20 _token;
    uint256 public votersCounter;
    uint256 public tokenCounter;
    mapping(address => bool) whoVoted;
    bool private _finalized;
    bool private _teste;

    constructor(ERC20 token) {
        _token = token;
        votersCounter = 0;
    }

    function vote() public {
        require(!_finalized);
        require(!whoVoted[msg.sender]);
        whoVoted[msg.sender] = true;
        votersCounter++;
        tokenCounter += _token.balanceOf(msg.sender);
    }

    function endVote() public {
        require(!_finalized);
        require(votersCounter > 2);
        require(tokenCounter > 5);
        _finalized = true;
    }
    
    function getStatus() public view returns(bool) {
        return _finalized;
    }

    function hasVoted(address acc) public view returns(bool) {
        return whoVoted[acc];
    }
}
