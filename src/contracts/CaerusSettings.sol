pragma solidity ^0.4.19;


import "./CaerusBase.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

contract CaerusSettings is CaerusBase {

    CaerusStorageInterface internal caerusStorage = CaerusStorageInterface(0);

    function allowUser(address _address) public onlyOwner {
        caerusStorage.setAddress(keccak256(USER_ADDRESS, _address), _address);
    }

    function disallowUser(address _address) public onlyOwner {
        caerusStorage.deleteAddress(keccak256(USER_ADDRESS, _address));
    }

    function updateContractAddress(string _contract, address _address) public onlyOwner {
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _contract), _address);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _address), _address);
    }

    function setRecruterMonthlyRate(uint256 _rate) public onlyOwner {
        caerusStorage.setUint(keccak256(RATE_RECRUTER), _rate);
    }

    function setJobSeekerMonthlyRate(uint256 _rate) public onlyOwner {
        caerusStorage.setUint(keccak256(RATE_JOB_SEEKER), _rate);
    }

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorageInterface(_caerusStorage);
    }

}