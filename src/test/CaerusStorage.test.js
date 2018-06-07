const CaerusStorage = artifacts.require('CaerusStorage');
const CaerusMembership = artifacts.require('CaerusMembership');

contract('CaerusMembership', accounts => {
  let storage;
  const owner = accounts[0];
  const buyer = accounts[1];
  const transferAddress = accounts[2];
  const initialSupply = 73e24;
  //How many tokens should be received per wei sent in
  //The math works out to be the same as the previous rate with the new 18 decimal place functionality written into the contract
  const tokenRateWei = 400; // use an even number for testing

  beforeEach(async function () {
    storage = await CaerusStorage.new({
      from: owner
    });
  });

  //Basic
  it('can store address', async function () {
    await storage.setAddress(web3.sha3("token.owner"), owner);
    var ownerAddress = await storage.getAddress(web3.sha3("token.owner"));
    console.log("token.owner:", ownerAddress);
    assert.equal(owner, ownerAddress);
  });

});