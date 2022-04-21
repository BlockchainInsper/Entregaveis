const VoteCoin = artifacts.require("VoteCoin");
const Governance = artifacts.require("TokenGovernance");

module.exports = function (deployer) {
  deployer.deploy(VoteCoin).then(function() {
    return deployer.deploy(Governance, VoteCoin.address);
  })
};