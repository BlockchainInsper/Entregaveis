const Coin = artifacts.require("Coin");
const TokenGovernance = artifacts.require("TokenGovernance");

module.exports = async function (deployer) {
  deployer.deploy(Coin).then(function() {
    return deployer.deploy(TokenGovernance, Coin.address);
  });
};
