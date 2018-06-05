const CaerusToken = artifacts.require('CaerusToken');

contract('CaerusToken', accounts => {
  let token;
  const owner = accounts[0];
  const buyer = accounts[1];
  const transferAddress = accounts[2];
  const vestedBeneficiary = accounts[3];
  const initialSupply = 73000000e18;
  //How many tokens should be received per wei sent in
  //The math works out to be the same as the previous rate with the new 18 decimal place functionality written into the contract
  const tokenRateWei = 400; // use an even number for testing

  beforeEach(async function () {
    token = await CaerusToken.new(transferAddress, tokenRateWei, {
      from: owner
    });
  });

  //Basic
  it('has a name', async function () {
    const name = await token.name();
    assert.equal(name, 'Caerus Token');
  });

  //Wait 1 second
  // it('should wait a second', () => {
  //   return new Promise((resolve, reject) => {
  //     setTimeout(resolve, 1000);
  //   })
  // });
});