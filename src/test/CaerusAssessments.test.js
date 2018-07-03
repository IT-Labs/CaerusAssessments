const CaerusStorage = artifacts.require('CaerusStorage');
const CaerusAssessments = artifacts.require('CaerusAssessments');
const CaerusSettings = artifacts.require('CaerusSettings');

contract('CaerusAssessments', accounts => {
  let storage;
  let assessments;
  let settings;
  const owner = accounts[0];
  const key = "user.assessment";
  const assessment = 321654987; 
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
    await assessments.setAssessment(key, assessment, {
      from: owner
    });
    var result = await assessments.getAssessment(key);
    assert.equal(assessment, result);
  });

  it('not equal assessment', async function () {
    await assessments.setAssessment(key, assessment, {
      from: owner
    });
    var result = await assessments.getAssessment(key);
    assert.notEqual(987654321, result);
  });

  it('wrong letter', async function () {
    var result = await assessments.getAssessment("notvalidkey");
    assert.notEqual(assessment, result);
  });
});