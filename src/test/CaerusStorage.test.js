const CaerusStorage = artifacts.require('CaerusStorage');

contract('CaerusStorage', accounts => {
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

  // Set, Get and Delete address
  //Basic
  it('can store address', async function () {
    await storage.setAddress(web3.sha3("token.owner"), owner);
    var ownerAddress = await storage.getAddress(web3.sha3("token.owner"));
    console.log("token.owner:", ownerAddress);
    console.log("token.owner:", owner);
    assert.equal(owner, ownerAddress);
  });

  //Delete Address
  it('deleted address', async function () {
    await storage.deleteAddress(web3.sha3("token.owner"));
    var ownerAddress = await storage.getAddress(web3.sha3("token.owner"));
    console.log("token.owner:", ownerAddress);
    assert.equal("0x0000000000000000000000000000000000000000", ownerAddress);
  });

  // Set, Get and Delete uint
  //Basic
  it('can store uint', async function () {
    var value = 3;
    await storage.setUint(web3.sha3("token.owner"), value);
    var ownerUInt = await storage.getUint(web3.sha3("token.owner"));
    console.log("token.owner:", ownerUInt);
    assert.equal(value, ownerUInt);
  });

  //Delete uint
  it('deleted uint', async function () {
    await storage.deleteUint(web3.sha3("token.owner"));
    var ownerUInt = await storage.getUint(web3.sha3("token.owner"));
    console.log("token.owner:", ownerUInt);
    assert.equal(0, ownerUInt);
  });

  // Set, Get and Delete int
  //Basic
  it('can store int', async function () {
    var value = 3;
    await storage.setInt(web3.sha3("token.owner"), value);
    var ownerInt = await storage.getInt(web3.sha3("token.owner"));
    console.log("token.owner:", ownerInt);
    assert.equal(value, ownerInt);
  });

  //Delete int
  it('deleted int', async function () {
    await storage.deleteInt(web3.sha3("token.owner"));
    var ownerInt = await storage.getInt(web3.sha3("token.owner"));
    console.log("token.owner:", ownerInt);
    assert.equal(0, ownerInt);
  });

  // Set, Get and Delete String
  //Basic
  it('can store String', async function () {
    var value = "etherium";
    await storage.setString(web3.sha3("token.owner"), value);
    var ownerString = await storage.getString(web3.sha3("token.owner"));
    console.log("token.owner:", ownerString);
    assert.equal(value, ownerString);
  });

  //Delete String
  it('deleted String', async function () {
    await storage.deleteString(web3.sha3("token.owner"));
    var ownerString = await storage.getString(web3.sha3("token.owner"));
    console.log("token.owner:", ownerString);
    assert.equal("", ownerString);
  });

  // Set, Get and Delete Bytes
  //Basic
  it('can store Bytes', async function () {
    var value = "0x3178";
    await storage.setBytes(web3.sha3("token.owner"), value);
    var ownerBytes = await storage.getBytes(web3.sha3("token.owner"));
    console.log("token.owner:", ownerBytes);
    assert.equal(value, ownerBytes);
  });

  //Delete Bytes
  it('deleted Bytes', async function () {
    await storage.deleteBytes(web3.sha3("token.owner"));
    var ownerBytes = await storage.getBytes(web3.sha3("token.owner"));
    console.log("token.owner:", ownerBytes);
    assert.equal("0x", ownerBytes);
  });

  // Set, Get and Delete Bool
  //Basic
  it('can store Bool', async function () {
    var value = true;
    await storage.setBool(web3.sha3("token.owner"), value);
    var ownerBool = await storage.getBool(web3.sha3("token.owner"));
    console.log("token.owner:", ownerBool);
    assert.equal(value, ownerBool);
  });

  //Delete Bool
  it('deleted Bool', async function () {
    await storage.deleteBool(web3.sha3("token.owner"));
    var ownerBool = await storage.getBool(web3.sha3("token.owner"));
    console.log("token.owner:", ownerBool);
    assert.equal(false, ownerBool);
  });

});