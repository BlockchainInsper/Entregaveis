// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract entregavel is ERC721, Ownable {
    uint256 public mintPrice = 0 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public canMint;

    constructor(
        string memory _name,
        string memory _symbol,
        uint64 cap
    ) ERC721(_name, _symbol) {
        require(cap > 0, "Erro : Capacidade de tokens nula");
        maxSupply = cap;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function _createNFT() internal onlyOwner {
        require(
            totalSupply < maxSupply,
            "Erro : Capacidade de tokens excedida"
        );
        uint256 tokenId = totalSupply;
        totalSupply++;
        _safeMint(msg.sender, tokenId);
    }

    function ownerMint() external onlyOwner {
        _createNFT();
    }

    function publicMint() external payable {
        require(msg.value > mintPrice, "Erro : Preco menor que taxas de mint");
        require(canMint);
        _createNFT();
    }

    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        mintPrice = _mintPrice;
    }

    function openSales(uint256 _mintPrice) external onlyOwner {
        canMint = true;
        setMintPrice(_mintPrice);
    }

    function closeSales() external onlyOwner {
        canMint = false;
    }

    function withdraw() external payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
