var CaerusStorage = artifacts.require("./CaerusStorage.sol");
var CaerusAssessments = artifacts.require("./CaerusAssessments.sol");
var CaerusToken = artifacts.require("./Token/CaerusToken.sol");
var CaerusMembership = artifacts.require("./CaerusMembership.sol");
var CaerusSettings = artifacts.require("./CaerusSettings.sol");

module.exports = function(deployer, network, accounts) {
  const multisigAddress = accounts[9];
  const ownerAddress = accounts[0];
  const TOKEN_OWNER = "token.owner";
  const tokenAddress = "0x79e8d325663dcd861c300129b0f59f3e928c70a8";
  //How many tokens should be received per wei sent in
  //The math works out to be the same as the previous rate with the new 18 decimal place functionality written into the contract
  const initialRate = 416;


  // deployer.deploy(CaerusToken, multisigAddress, initialRate).then(() => {
  //   return CaerusToken.deployed().then(t => {
  //     token = t;
      console.log("Token address:", tokenAddress);
      deployer.deploy(CaerusStorage).then(() => {
        return CaerusStorage.deployed()
          .then(s => {
            storage = s;
            console.log("Storage address:", storage.address);
            return deployer.deploy(CaerusSettings, storage.address);
          })
          .then(() => {
            return CaerusSettings.deployed().then(q => {
              settings = q;              
              settings.setContractAddress("caerus.settings", settings.address);
              settings.setTokenAddress(tokenAddress);
              settings.setTokenOwner(ownerAddress);
              settings.setRecruterMonthlyRate(3e18);
              settings.setJobSeekerMonthlyRate(1e18);

              return deployer.deploy(CaerusMembership, storage.address);
            });
          })
          .then(() => {
            return CaerusMembership.deployed().then(m => {
              membership = m;
              settings.setContractAddress("caerus.membership", membership.address);
              return deployer.deploy(CaerusAssessments, storage.address);
            });
          })          
          .then(() => {
            return CaerusAssessments.deployed().then(a => {
              assessments = a;
              settings.setContractAddress("caerus.assessments", assessments.address);
              //storage.setBool(web3.sha3("contract.storage.initialised"), true);
            });
          });
      });
  //   });
  // });
};
