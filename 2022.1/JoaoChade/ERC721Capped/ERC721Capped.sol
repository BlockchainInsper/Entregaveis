// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable {

    uint _cap;
    uint price;
    bool mint;
    uint tokensCreated;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol) {
        _cap = cap;

        price = 0;
        mint = false;
        tokensCreated = 0;
    }

    function getTotalSupply() public view returns (uint) {
        return tokensCreated;
    } 

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function _createNFT() internal {
        require(tokensCreated < _cap);
        tokensCreated++;
        _mint(msg.sender, tokensCreated);
    }

    function ownerMint() public onlyOwner {
        _createNFT();
    }

    function publicMint() public payable{
        require(msg.value >= price);
        require(mint);
        _createNFT();
    }

    function setMintPrice(uint _price) public onlyOwner {
        price = _price;
    }

    function openSales(uint _price) public onlyOwner {
        mint = true;
        setMintPrice(_price);
    }

    function closeSales() public onlyOwner {
        mint = false;
    }

    function withdraw() external onlyOwner {
        address payable _owner = payable(address(owner()));
        _owner.transfer(address(this).balance);
  }
}