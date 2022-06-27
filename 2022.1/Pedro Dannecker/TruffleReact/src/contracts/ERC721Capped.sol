// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Capped is ERC721 {
    // Variáveis
    uint64 cap;
    address payable public owner;
    uint mintprice;
    bool sales;
    uint index;
    constructor(string  memory name_,string memory symbol_ ,uint64  _cap) ERC721 (name_,symbol_)  {
        cap=_cap;
        owner= payable(msg.sender);
        index=0;
        sales=false;

       
    }
    function getBalance() public view returns(uint256){
        return address(this).balance;
        }
    modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

    function withdraw() public onlyOwner {
            owner.transfer(address(this).balance);
            //Transfer(address(this),owner, address(this).balance);
            
        }
    function setMintPrice(uint valor_) public onlyOwner{
        mintprice=valor_;
    } 
    function _createNFT()  internal{
        require(index < cap);
        index++;
        _mint(msg.sender,index);
        

    }  
    function getTotalSupply() view external returns(uint){
        return index;
    } 
    function ownerMint() public onlyOwner{
        _createNFT();
    }
    function publicMint() payable public {
        require(msg.value>=mintprice);
        require(sales==true);
        _createNFT();
    }
    function openSales(uint price) public onlyOwner{
        sales =true;
        setMintPrice(price);

    }
    function closeSales() public onlyOwner{
        sales=false;
    }



}