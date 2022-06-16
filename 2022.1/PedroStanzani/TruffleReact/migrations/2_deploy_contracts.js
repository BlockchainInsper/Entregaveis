const ERC721Capped = artifacts.require("ERC721Capped");

module.exports = function (deployer) {
  deployer.deploy(ERC721Capped, "Example", "EXP", 10);
};