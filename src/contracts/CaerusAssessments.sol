pragma solidity ^0.4.19;


import "./CaerusBase.sol";


contract CaerusAssessments is CaerusBase {
    event SetAssessmentEvent(
        string _assessmentId
    );
    
    function setAssessment( string _assessmentId, uint256 _result) external onlyAllowedUsers returns (bool) {
        caerusStorage.setUint(keccak256(_assessmentId), _result);
        emit SetAssessmentEvent( _assessmentId);
        return true;
    }

    function getAssessment(string _assessmentId) external view returns (uint256) {  
        return caerusStorage.getUint(keccak256( _assessmentId));
    }

    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }
}