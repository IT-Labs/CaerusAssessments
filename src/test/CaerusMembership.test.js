const CaerusToken = artifacts.require('CaerusToken');
const CaerusMembership = artifacts.require('CaerusMembership');
const CaerusStorage = artifacts.require('CaerusStorage');
const CaerusSettings = artifacts.require('CaerusSettings');

contract('CaerusMembership', accounts => {
  let token;
  let storage;
  let membership;
  let settings;
  const owner = accounts[0];
  const buyer = accounts[1];
  const transferAddress = accounts[2];
  const vestedBeneficiary = accounts[3];
  const initialSupply = 73000000e18;
  const RATE_RECRUTER = "rate.recruter";
  const RATE_JOB_SEEKER = "rate.jobseeker";
  //How many tokens should be received per wei sent in
  //The math works out to be the same as the previous rate with the new 18 decimal place functionality written into the contract
  const tokenRateWei = 400; // use an even number for testing
  const tokenAddress = "0x79e8d325663dcd861c300129b0f59f3e928c70a8";

  beforeEach(async function () {
    token = await CaerusToken.new(transferAddress, tokenRateWei, {
      from: owner
    });
    
    storage = await CaerusStorage.new({
      from: owner
    });

    membership = await CaerusMembership.new(storage.address,{
      from: owner
    });

    settings = await CaerusSettings.new(storage.address,{
      from: owner
    });

    settings.setRecruterMonthlyRate(3e18);
    settings.setJobSeekerMonthlyRate(1e18);
    settings.setContractAddress("caerus.settings", settings.address);
    settings.setContractAddress("caerus.membership", membership.address);
    settings.setTokenAddress(tokenAddress);
    settings.setTokenOwner(owner);

  });

  //Basic
  it('has a name', async function () {
    const name = await token.name();
    assert.equal(name, 'Caerus Token');
    
  });

  //Basic
  it('has a rate', async function () {
    const rate = await membership.getRate(RATE_RECRUTER);
    console.log("rate", rate);
    assert.equal(rate, 3e18);
    
  });

  //Basic
  it('has a token address', async function () {
    const tokenAddressResult = await membership.getTokenAddress();
    console.log("token address", tokenAddressResult);
    assert.equal(tokenAddressResult, tokenAddress);
    
  });

  //Wait 1 second
  // it('should wait a second', () => {
  //   return new Promise((resolve, reject) => {
  //     setTimeout(resolve, 1000);
  //   })
  // });
});