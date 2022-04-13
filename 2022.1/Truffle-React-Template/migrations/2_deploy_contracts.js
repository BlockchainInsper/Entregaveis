const Coin = artifacts.require("Coin");
const TokenGovernance = artifacts.require("TokenGovernance");

module.exports = function (deployer, network, accounts) {
  const deployerAddress = accounts[0]; 
  deployer.deploy(Coin, "Teste", "TXT", deployerAddress, 20000000000000);
  // deployer.deploy(TokenGovernance);
};