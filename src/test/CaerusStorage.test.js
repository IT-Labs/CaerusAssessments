const CaerusStorage = artifacts.require('CaerusStorage');

contract('CaerusStorage', accounts => {
  let storage;
  const owner = accounts[0];
  const key = web3.sha3("some.key"); 
  beforeEach(async function () {
    storage = await CaerusStorage.new({
      from: owner
    });
  });

  // Set, Get and Delete address
  //Basic
  it('can store address', async function () {
    await storage.setAddress(key, owner);
    var valueAddress = await storage.getAddress(key);
    assert.equal(owner, valueAddress);
  });

  //Delete Address
  it('deleted address', async function () {
    await storage.setAddress(key, owner);
    await storage.deleteAddress(key);
    var valueAddress = await storage.getAddress(key);
    assert.equal("0x0000000000000000000000000000000000000000", valueAddress);
  });

  // Set, Get and Delete uint
  //Basic
  it('can store uint', async function () {
    var value = 3;
    await storage.setUint(key, value);
    var valueUInt = await storage.getUint(key);
    assert.equal(value, valueUInt);
  });

  //Delete uint
  it('deleted uint', async function () {
    await storage.deleteUint(key);
    var valueUInt = await storage.getUint(key);
    assert.equal(0, valueUInt);
  });

  // Set, Get and Delete int
  //Basic
  it('can store int', async function () {
    var value = 3;
    await storage.setInt(key, value);
    var valueInt = await storage.getInt(key);
    assert.equal(value, valueInt);
  });

  //Delete int
  it('deleted int', async function () {
    await storage.deleteInt(key);
    var valueInt = await storage.getInt(key);
    assert.equal(0, valueInt);
  });

  // Set, Get and Delete String
  //Basic
  it('can store String', async function () {
    var value = "etherium";
    await storage.setString(key, value);
    var valueString = await storage.getString(key);
    assert.equal(value, valueString);
  });

  //Delete String
  it('deleted String', async function () {
    await storage.deleteString(key);
    var valueString = await storage.getString(key);
    assert.equal("", valueString);
  });

  // Set, Get and Delete Bytes
  //Basic
  it('can store Bytes', async function () {
    var value = "0x3178";
    await storage.setBytes(key, value);
    var valueBytes = await storage.getBytes(key);
    assert.equal(value, valueBytes);
  });

  //Delete Bytes
  it('deleted Bytes', async function () {
    await storage.deleteBytes(key);
    var valueBytes = await storage.getBytes(key);
    assert.equal("0x", valueBytes);
  });

  // Set, Get and Delete Bool
  //Basic
  it('can store Bool', async function () {
    var value = true;
    await storage.setBool(key, value);
    var valueBool = await storage.getBool(key);
    assert.equal(value, valueBool);
  });

  //Delete Bool
  it('deleted Bool', async function () {
    await storage.deleteBool(key);
    var valueBool = await storage.getBool(key);
    assert.equal(false, valueBool);
  });

});