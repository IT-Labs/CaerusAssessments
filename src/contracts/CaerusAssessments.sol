pragma solidity ^0.4.19;


import "./Interfaces/CaeruStorageInterface.sol";


contract CaerusAssessments {

    CaeruStorageInterface private caerusStorage = CaeruStorageInterface(0);

    constructor(address _caerusStorage) public {
        caerusStorage = CaeruStorageInterface(_caerusStorage);
    }

}