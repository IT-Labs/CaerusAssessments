const CaerusStorage = artifacts.require('CaerusStorage');
const CaerusAssessments = artifacts.require('CaerusAssessments');
const CaerusSettings = artifacts.require('CaerusSettings');

contract('CaerusAssessments', accounts => {
  let storage;
  let assessments;
  let settings;
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

    settings = await CaerusSettings.new(storage.address, {
      from: owner
    });

    assessments = await CaerusAssessments.new(storage.address, {
      from: owner
    });

    settings.allowUser(owner);
  });

  // Set, Get and Delete address
  //Basic
  it('can store assessment', async function () {
    await assessments.setAssessment("a",123456789, {
      from: owner
    });
    var result = await assessments.getAssessment("a", {
      from: owner
    });
    console.log(result);
    assert.equal(123456789, result);
  });


});