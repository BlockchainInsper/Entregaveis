// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AcordoCompra {
    uint public preco;
    address payable public vendedor;
    address payable public comprador;
    
    enum Estado { Criado, Trancado, Livre, Inativo }
    Estado public estado;

    constructor() payable {
        vendedor = payable(msg.sender);
        preco = msg.value / 2;
    }

    /// A funcao nao pode ser chamada neste estado.
    error EstadoInvalido();
    ///  Somente o comprador pode chamar esta funcao
    error SomenteComprador();
    ///  Somente o vendedor pode chamar esta funcao
    error SomenteVendedor();

    modifier inState(Estado estado_) {
        if (estado != estado_) {
            revert EstadoInvalido();
        }
        _;
    }

    modifier somenteComprador() {
        if (msg.sender != comprador) {
            revert SomenteComprador();
        }
        _;
    }

    modifier somenteVendedor() {
        if (msg.sender != vendedor) {
            revert SomenteVendedor();
        }
        _;
    }

    function confirmaCompra() external inState(Estado.Criado) payable {
        require(msg.value == (2 * preco), "Por favor enviar o dobro do valor do preco");
        comprador = payable(msg.sender);
        estado = Estado.Trancado;
    }

    function confirmaRecebimento() external somenteComprador inState(Estado.Trancado) {
        estado = Estado.Livre;
        comprador.transfer(preco);
    }

    function pagaVendedor() external somenteVendedor inState(Estado.Livre) {
      estado = Estado.Inativo;
      vendedor.transfer(3 * preco);
    }

    function abortar() external somenteVendedor inState(Estado.Criado) {
        estado = Estado.Inativo;
        vendedor.transfer(address(this).balance);
    }


}