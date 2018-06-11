pragma solidity ^0.4.19;


import "./CaerusBase.sol";


contract CaerusAssessments is CaerusBase {
    event SetAssessmentEvent(
        string indexed _userId,
        string indexed _assessmentId
    );
    function setAssessment(string _userId, string _assessmentId, string _result) external onlyAllowedUsers returns (bool) {
        caerusStorage.setString(keccak256("assessment.", _userId, _assessmentId), _result);
        emit SetAssessmentEvent(_userId, _assessmentId);
        return true;
    }

    function getAssessment(string _userId, string _assessmentId) external view returns (string) {  
        return caerusStorage.getString(keccak256("assessment.", _userId, _assessmentId));
    }

    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }
}