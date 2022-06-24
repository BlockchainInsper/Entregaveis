const Tutorial = artifacts.require("Tutorial");
const ERC721Capped = artifacts.require("ERC721Capped");

module.exports = function (deployer) {
  deployer.deploy(Tutorial);
  deployer.deploy(ERC721Capped, "BI Insper", "BI", 100);
};