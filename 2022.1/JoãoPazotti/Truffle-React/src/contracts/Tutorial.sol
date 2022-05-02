
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Tutorial{

   string frase = "Hello world";

   function set(string memory _frase ) public {
       frase = _frase;
   }
   
   function get() public view returns (string memory) {
       return frase;
   }

}