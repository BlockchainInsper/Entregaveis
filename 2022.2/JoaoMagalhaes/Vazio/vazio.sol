// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract nao_Vazio {

    function destroy(address payable adr) public payable {
        address payable addr = payable(address(adr));
        selfdestruct(addr);
    }

    fallback() payable external {}
    receive() payable external {}
}

//0xdA22c066DA82B903784DCC5477beD6F7d93828c9