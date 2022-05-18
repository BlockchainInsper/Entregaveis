// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract entregavel is ERC721, Ownable {

    
    uint tokenCount;
    uint public mintPrice = 0.5 ether;
    uint public totalSupply;
    uint public maxSupply;
    bool public isMintEnabled;


    constructor(string memory _name, string memory _symbol, uint64 cap) ERC721(_name, _symbol) {
        totalSupply = cap;
    }

    function getTotalSupply() public view returns(uint) {
        return totalSupply;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
   
    function _createNFT() internal onlyOwner {
        require(totalSupply < maxSupply);
        uint256 tokenId = totalSupply;
        totalSupply++;
        _safeMint(msg.sender, tokenId);
    }

    function ownerMint() external onlyOwner {
        _createNFT();
    }
    function publicMint() payable external {
        require(msg.value >= mintPrice);
        require(isMintEnabled);
        _createNFT();
    }

    function setMintPrice(uint _mintPrice) internal onlyOwner {
        mintPrice = _mintPrice;
    }

    function openSales(uint _mintPrice) external onlyOwner {
        isMintEnabled = true;
        setMintPrice(_mintPrice);
    }

    function closeSales() external onlyOwner {
        isMintEnabled = false;
    }
    
    function withdraw() payable external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

}