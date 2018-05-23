var CaerusStorage = artifacts.require("./CaerusStorage.sol");
var CaerusAssessments = artifacts.require("./CaerusAssessments.sol");
var CaerusToken = artifacts.require("./Token/CaerusToken.sol");
var CaerusMembership = artifacts.require("./CaerusMembership.sol");
var CaerusSettings = artifacts.require("./CaerusSettings.sol");

module.exports = function(deployer, network, accounts) {
  const multisigAddress = accounts[9];
  const ownerAddress = accounts[0];
  const TOKEN_OWNER = "token.owner";
  //How many tokens should be received per wei sent in
  //The math works out to be the same as the previous rate with the new 18 decimal place functionality written into the contract
  const initialRate = 416;
  const setAddress = (caerusStorage, contractName, contract) => {
    console.log(` ${contractName} address: ${contract.address}`);
    storage.setBool(web3.sha3("contract.address", contract.address), true);
    storage.setAddress(
      web3.sha3("contract.address", contract.address),
      contract.address
    );
    storage.setAddress(
      web3.sha3("contract.address", contractName),
      contract.address
    );
  };

  deployer.deploy(CaerusToken, multisigAddress, initialRate).then(() => {
    return CaerusToken.deployed().then(t => {
      token = t;
      console.log("Token address:", token.address);
      deployer.deploy(CaerusStorage).then(() => {
        return CaerusStorage.deployed()
          .then(s => {
            storage = s;
            console.log("Storage address:", storage.address);
            setAddress(storage, "caerus.token", token);
            storage.setAddress(web3.sha3(TOKEN_OWNER), ownerAddress);

            return deployer.deploy(CaerusMembership, storage.address);
          })
          .then(() => {
            return CaerusMembership.deployed().then(m => {
              membership = m;
              setAddress(storage, "caerus.membership", membership);
              return deployer.deploy(CaerusSettings, storage.address);
            });
          })
          .then(() => {
            return CaerusSettings.deployed().then(t => {
              settings = t;
              setAddress(storage, "caerus.settings", settings);

              settings.setRecruterMonthlyRate(3e18);
              settings.setJobSeekerMonthlyRate(1e18);

              return deployer.deploy(CaerusAssessments, storage.address);
            });
          })
          .then(() => {
            return CaerusAssessments.deployed().then(a => {
              assessments = a;
              setAddress(storage, "caerus.assessments", assessments);
              storage.setBool(web3.sha3("contract.storage.initialised"), true);
            });
          });
      });
    });
  });
};
