var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "some words :)";
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      network_id: "*" // eslint-disable-line camelcase
    },
    ropsten: { 
      provider: function() { 
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/IyFnJGhaYQV2dRHD7EkW", 0) 
      }, 
      network_id: 3, 
      //from: "0xC2fdd99ce48D5e0191c1d77d17f88aa61370033F" 
      gasPrice: 9000000000,
      gas: 4500000
    }, 
  } 
};