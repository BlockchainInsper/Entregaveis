pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract ICO is Ownable {
    
    mapping (address => uint) Patrimonio;
    
    function _CriarMoeda(uint qtdcomprada) internal {
        for (uint i = 0; i < qtdcomprada; i++) {
            Patrimonio[msg.sender]++;
        }
    }
    
    function _ComprarMoeda() public payable {
        uint256 compra = uint256(msg.value);
        _CriarMoeda(compra);
    }
    
    function _VerPatrimonio(address _owner) external view returns(uint256) {
          return Patrimonio[_owner];
    }
    
    function _transfer(address _to, uint qtde) external {
    
        require(Patrimonio[msg.sender] >= qtde);
        for (uint i = 0; i < qtde; i++) {
            Patrimonio[_to]++;
            Patrimonio[msg.sender]--;
        }
    }

}
