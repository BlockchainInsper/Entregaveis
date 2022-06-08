const Tutorial = artifacts.require("Tutorial");

module.exports = function (deployer) {
  deployer.deploy(Tutorial);
};