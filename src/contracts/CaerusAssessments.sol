pragma solidity ^0.4.19;


import "./Interfaces/CaerusStorageInterface.sol";


contract CaerusAssessments {

    CaerusStorageInterface private caerusStorage = CaerusStorageInterface(0);

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorageInterface(_caerusStorage);
    }

}