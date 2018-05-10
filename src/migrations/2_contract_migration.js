var CaerusStorage = artifacts.require("./CaerusStorage.sol");
var CaerusAssessments = artifacts.require("./CaerusAssessments.sol");

module.exports = function(deployer, network, accounts) {
  // deployer.deploy(CaerusStorage) 
  // .then(() => {
  //   return CaerusStorage.deployed()
  //   .then(s => {
  //     storage = s
  //     console.log('Storage address:', storage.address);
  //     return deployer.deploy(CaerusAssessments, storage.address);
  //   }) 
  //   .then(() => {
  //     return CaerusAssessments.deployed()
  //     .then(a => {
  //       assessment = a
  //       console.log('Assessment address:', assessment.address);
        
  //       storage.setBool(keccak256("contract.address", assessment.address), true);


  //       storage.setBool(keccak256("contract.storage.initialised"), true);
  //     }) 

  //   });
  // });
};
