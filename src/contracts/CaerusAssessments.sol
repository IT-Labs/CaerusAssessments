pragma solidity ^0.4.19;


import "./CaerusBase.sol";

/**
 * @title Caerus Assessments.
 * @dev Implementation of the Caerus Assessments - contract that stores Job Seekers assessment test results.
 */
contract CaerusAssessments is CaerusBase {
    event SetAssessmentEvent(
        string _assessmentId
    );
    /**
    * @dev Sets the assessment result for a Job Seeker. Only Allowed known addresses can use it.
    * @param _assessmentId combination of JobSeekerId and the Assessment Id.
    * @param _result actual assessment result.
    */
    function setAssessment(string _assessmentId, uint256 _result) external onlyAllowedUsers returns (bool) {
        caerusStorage.setUint(keccak256(_assessmentId), _result);
        emit SetAssessmentEvent( _assessmentId);
        return true;
    }
    /**
    * @dev Gets the assessment result for a Job Seeker and Assessment Id
    * @param _assessmentId combination of JobSeekerId and the Assessment Id.
    * @return integer that represents the stored assessment result.
    */
    function getAssessment(string _assessmentId) external view returns (uint256) {  
        return caerusStorage.getUint(keccak256( _assessmentId));
    }

    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }
}