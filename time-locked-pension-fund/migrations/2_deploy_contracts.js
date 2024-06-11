// var TimeLockedWallet = artifacts.require("TimeLockedWallet");
var TimeLockedWalletFactory = artifacts.require("TimeLockedWalletFactory");

module.exports =async function(deployer) {
  // await deployer.deploy(TimeLockedWallet);
  await deployer.deploy(TimeLockedWalletFactory);
  
};
