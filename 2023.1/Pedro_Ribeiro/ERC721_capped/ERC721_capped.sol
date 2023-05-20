// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT_capped is ERC721, Ownable {
    uint public cap;
    uint public price;
    bool public sales;
    uint public totalSupply;

    mapping(uint => uint) public tokenEtherAmount;
    
    constructor(string memory _name, string memory _symbol, uint _cap) ERC721(_name, _symbol) {
        cap = _cap;
        totalSupply = 0;
        sales = false;
        price = 0;
    }

    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function getBalance() public view returns (uint) {
        return msg.sender.balance;
    }

    function _createNFT() internal {
        require(cap > totalSupply, "Esgotou");
        _safeMint(msg.sender, totalSupply);
        totalSupply++;
    }

    function ownerMint() internal onlyOwner {
        _createNFT();
    }

    function publicMint() public payable {
        require(sales == true, "As vendas estao fechadas");
        require(getBalance() >= price, "Ether insuficiente");
        _createNFT();
    }

    function setMintPrice(uint _price) internal onlyOwner {
        price = _price;
    }

    function openSales(uint _price) internal onlyOwner {
        sales = true;
        setMintPrice(_price);
    }

    function closeSales() internal onlyOwner {
        sales = false;
    }

    function withdraw() external onlyOwner {
        uint balance = getBalance();
        require(balance > 0, "Nada para sacar");

        payable(owner()).transfer(balance);
    }


}