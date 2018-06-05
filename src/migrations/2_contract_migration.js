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
  const setAddress = (caerusStorage, contractName, contractAddress) => {
    console.log(` ${contractName} address: ${contractAddress}`);
    storage.setBool(web3.sha3("contract.address", contractAddress), true);
    console.log(` ${contractName} sha3: ${web3.sha3("contract.address", contractAddress)}`);
    storage.setAddress(web3.sha3("contract.address", contractAddress), contractAddress);
    storage.setAddress(web3.sha3("contract.address", contractName), contractAddress);
  };

  // deployer.deploy(CaerusToken, multisigAddress, initialRate).then(() => {
  //   return CaerusToken.deployed().then(t => {
  //     token = t;
      console.log("Token address:", tokenAddress);
      deployer.deploy(CaerusStorage).then(() => {
        return CaerusStorage.deployed()
          .then(s => {
            storage = s;
            console.log("Storage address:", storage.address);

            setAddress(storage, "caerus.token", tokenAddress);
            storage.setAddress(web3.sha3(TOKEN_OWNER), ownerAddress);

            return deployer.deploy(CaerusMembership, storage.address);
          })
          .then(() => {
            return CaerusMembership.deployed().then(m => {
              membership = m;
              setAddress(storage, "caerus.membership", membership.address);
              return deployer.deploy(CaerusSettings, storage.address);
            });
          })
          .then(() => {
            return CaerusSettings.deployed().then(q => {
              settings = q;
              setAddress(storage, "caerus.settings", settings.address);

              settings.setRecruterMonthlyRate(3e18);
              settings.setJobSeekerMonthlyRate(1e18);

              return deployer.deploy(CaerusAssessments, storage.address);
            });
          })
          .then(() => {
            return CaerusAssessments.deployed().then(a => {
              assessments = a;
              setAddress(storage, "caerus.assessments", assessments.address);
              //storage.setBool(web3.sha3("contract.storage.initialised"), true);
            });
          });
      });
  //   });
  // });
};
