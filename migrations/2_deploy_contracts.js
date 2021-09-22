const CardToken = artifacts.require('CardToken');
const NFTMarketplace = artifacts.require('NFTMarketplace');

module.exports = async function (deployer) {
  await deployer.deploy(CardToken, 'CardToken', 'CardToken', '10000000000000000000000').then(() => deployer.deploy(NFTMarketplace, CardToken.address));
};
