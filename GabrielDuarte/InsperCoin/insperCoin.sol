pragma solidity ^0.4.19;

contract InsperCoin {
    
    struct Client {
        address clientId;
        uint ICoins;
    }
    
    mapping(address => Client) private clients;
    
    
    function buyICoins(uint256 value) public{
        clients[msg.sender].clientId = msg.sender;
        clients[msg.sender].ICoins += value;
    }
    
    function sellICoins(uint256 amount) public returns (uint256){
        if (clients[msg.sender].ICoins >= amount) {
            clients[msg.sender].ICoins -= amount;   
            return clients[msg.sender].ICoins;
        }
        return 0;
    }
    
    function getBalance() public view returns (uint256){ 
        if (clients[msg.sender].ICoins != 0) {
            return clients[msg.sender].ICoins;
        }
        return 0;
    }
}