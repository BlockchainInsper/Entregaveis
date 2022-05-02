pragma solidity >=0.4.22 <0.9.0;

import "./Token.sol";
import "./Coin.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Governance{

    Token public _activeGovernance;

    constructor() {
        ERC20 curToken = new Coin("jao", "jv", 0x85A1339bC34E33a91048B76197e46361Fc6F9A2b, 20000000000000000000);
        _activeGovernance = new Token(curToken);
    }

    function getGovernance() public view returns(Token) {
        return _activeGovernance;
    }

    function getGovernanceStatus() public view returns(bool) {
        return _activeGovernance.getStatus();
    }

    function getToken() public view returns(ERC20) {
        return _activeGovernance.getToken();
    }

}