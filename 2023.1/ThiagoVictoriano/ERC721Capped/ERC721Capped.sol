// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable{
    uint64 capac;
    uint tokensMade;
    bool mint;
    uint price;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol) {
        capac = cap;
        tokensMade = 0;
        mint = false;
        price = 0;
    }

    function getTotalSupply() public view returns(uint){
        return(tokensMade);
    }

    function getBalance() public view returns(uint){
        return(address(this).balance);
    }

    function _createNFT() internal{
        require (tokensMade < capac);
        tokensMade++;
        _safeMint(msg.sender, tokensMade);
    }

    function ownerMint() external onlyOwner(){
        _createNFT();
    }

    function publicMint() external payable{
        require(msg.value >= price);
        require (mint == true);
        _createNFT();
    }

    function setMintPrice(uint _newPrice) public onlyOwner{
        price = _newPrice;
    }

    function openSales(uint _newPrice) external onlyOwner{
        mint = true;
        setMintPrice(_newPrice);
    }

    function closeSales() external onlyOwner{
        mint = false;
    }

    function withdraw() external onlyOwner{
        address payable _owner = payable(address(uint160(owner())));
        _owner.transfer(address(this).balance);
    }
}