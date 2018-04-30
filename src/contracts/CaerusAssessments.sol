pragma solidity ^0.4.19;


import "./Interfaces/CaerusStorageInterface.sol";


contract CaerusAssessments {

    CaerusStorageInterface private caerusStorage = CaerusStorageInterface(0);



    function storeAssessment(string _userId, string _assessment) external returns (bool) {
        caerusStorage.setString(keccak256("assessment.", _userId), _assessment);
        return true;
    }

    function getAssessment(string _userId) external returns (string) {  
        return caerusStorage.getString(keccak256("assessment.", _userId));
    }

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorageInterface(_caerusStorage);
    }

}