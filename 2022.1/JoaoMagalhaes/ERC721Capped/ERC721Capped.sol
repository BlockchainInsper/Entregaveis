// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Capped is ERC721 {

    uint64 _maxTokens;
    uint64 _totalTokens;
    address owner;
    bool _isOpen;
    uint _nftPrice;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol){
        _maxTokens = cap;
        _totalTokens = 0;
        owner = msg.sender;
        _isOpen = false;
        _nftPrice = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function getTotalSupply() public view returns (uint64) {
        return _totalTokens;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function _createNFT() internal {
        require(_totalTokens < _maxTokens);
        _totalTokens++;
        _mint(msg.sender, _totalTokens);
    }

    function ownerMint() external onlyOwner {
       _createNFT();
    }

    function publicMint() external payable {
        require(msg.value >= _nftPrice && _isOpen);
        _createNFT();
    }

    function setMintPrice(uint newNftPrice) public onlyOwner {
        _nftPrice = newNftPrice;
    }

    function openSales(uint newNftPrice) public onlyOwner {
        _isOpen = true;
        setMintPrice(newNftPrice);
    }

    function closeSales() external onlyOwner {
        _isOpen = false;
    }

    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}