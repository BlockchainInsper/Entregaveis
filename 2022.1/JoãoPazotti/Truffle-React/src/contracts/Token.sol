pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Coin.sol";


contract Token{

    ERC20 public _token;
    uint256 public voterCounter;
    uint256 public tokenCounter;
    mapping(address => bool) whoVoted;
    bool private _finalized;

    constructor(ERC20 tokenCoin) {
        _token = tokenCoin;
    }

    function vote() public {
        require(!_finalized);
        require(!whoVoted[msg.sender]);
        whoVoted[msg.sender] = true;
        voterCounter++;
        tokenCounter += _token.balanceOf(msg.sender);
    }

    function endVote() public {
        require(!_finalized);
        require(voterCounter >= 1);
        require(tokenCounter >= 1);
        _finalized = true;
    }

    function getStatus() public view returns(bool) {
        return _finalized;
    }

    function getToken() public view returns(ERC20) {
        return _token;
    }

    function hasVoted(address acc) public view returns(bool) {
        return whoVoted[acc];
    }


}