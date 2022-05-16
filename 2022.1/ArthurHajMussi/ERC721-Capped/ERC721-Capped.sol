// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable {
   

uint _maxSupply;
uint _mintPrice;
bool _mintOpen = false; 
uint _currentSupply;

 constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol) {
     _maxSupply = cap;
    }

function getTotalSupply() public view returns(uint) {
    return _currentSupply;
}

function getBalance() public view returns(uint) {
    return address(this).balance;
}

function _createNFT() internal {
    require(_currentSupply < _maxSupply);
    _currentSupply++;
}

function ownerMint() external onlyOwner {
    _createNFT();
}

function publicMint() public payable {
    require (_mintOpen && msg.value == _mintPrice);
    _createNFT();
}

function setMintPrice(uint mintPrice) public onlyOwner {
    _mintPrice = mintPrice;
}

function openSales(uint mintPrice) external onlyOwner {
    _mintOpen = true;
    setMintPrice(mintPrice);
}

function closeSales() external onlyOwner {
    _mintOpen = false;
}

function withdraw() public payable onlyOwner {
    payable(owner()).transfer(address(this).balance);
}
  }
