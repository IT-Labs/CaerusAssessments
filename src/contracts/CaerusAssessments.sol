pragma solidity ^0.4.19;


import "./CaerusBase.sol";


contract CaerusAssessments is CaerusBase {

    function storeAssessment(string _userId, string _assessmentId, string _result) external onlyAllowedUsers returns (bool) {
        caerusStorage.setString(keccak256("assessment.", _userId, _assessmentId), _result);
        return true;
    }

    function getAssessment(string _userId, string _assessmentId) external view returns (string) {  
        return caerusStorage.getString(keccak256("assessment.", _userId, _assessmentId));
    }

    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }
}