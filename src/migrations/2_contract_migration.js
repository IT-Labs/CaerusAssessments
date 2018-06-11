var CaerusStorage = artifacts.require("./CaerusStorage.sol");
var CaerusAssessments = artifacts.require("./CaerusAssessments.sol");
var CaerusSettings = artifacts.require("./CaerusSettings.sol");

module.exports = function(deployer, network, accounts) {
  const ownerAddress = accounts[0];
  const tokenAddress = "0x79e8d325663dcd861c300129b0f59f3e928c70a8";

  deployer.deploy(CaerusStorage).then(() => {
    return CaerusStorage.deployed()
      .then(s => {
        storage = s;
        return deployer.deploy(CaerusAssessments, storage.address);
      })
      .then(() => {
        return CaerusAssessments.deployed().then(a => {
          assessments = a;
          return deployer.deploy(CaerusSettings, storage.address);
        });
      })
      .then(() => {
        return CaerusSettings.deployed().then(q => {
          settings = q;
          settings.setToken(tokenAddress, ownerAddress);
          settings.setContractAddress("caerus.settings", settings.address);
          settings.setContractAddress("caerus.assessments", assessments.address);
          settings.setStorageInitialized();
          settings.allowUser(ownerAddress);
        });
      });
  });
};
