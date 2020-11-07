pragma solidity ^0.4.19;

import "./Ownable.sol";

contract InsperCoin is Ownable{
    
    string private name = "Insper Coin";
    string private symbol = "IPC";
    uint private totalSupply = 0;
    uint private exchangeRate = 1 finney;
    
    mapping(address => uint) balance;
    
    
    function _resetExchangeRate(uint _rate) public onlyOwner{
        exchangeRate = _rate * 1 finney;
    }
    
    function buy(uint _amount) public payable {
        require(msg.value == _amount*exchangeRate);
        balance[msg.sender] += _amount;
        totalSupply += _amount;
    }
    
    function transfer(address _to, uint _value) public {
        require(balance[msg.sender] >= _value);
        balance[msg.sender] -= _value;
        balance[_to] += _value;
    }
    
    function getBalance(address _address) view public returns (uint){
        return balance[_address];
    }
    
    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }
}