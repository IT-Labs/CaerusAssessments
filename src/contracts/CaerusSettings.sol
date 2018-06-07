pragma solidity ^0.4.19;


import "./CaerusBase.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

contract CaerusSettings is CaerusBase {

    function allowUser(address _address) public onlyOwner {
        caerusStorage.setAddress(keccak256(USER_ADDRESS, _address), _address);
    }

    function disallowUser(address _address) public onlyOwner {
        caerusStorage.deleteAddress(keccak256(USER_ADDRESS, _address));
    }

    function setContractAddress(string _contract, address _address) public onlyOwner {
        caerusStorage.setBool(keccak256(CONTRACT_ADDRESS, _address), true);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _contract), _address);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _address), _address);
    }

    function setRecruterMonthlyRate(uint256 _rate) public onlyOwner {
        caerusStorage.setUint(keccak256(RATE_RECRUTER), _rate);
    }

    function setJobSeekerMonthlyRate(uint256 _rate) public onlyOwner {
        caerusStorage.setUint(keccak256(RATE_JOB_SEEKER), _rate);
    }

    function setTokenAddress(address _tokenAddress) public onlyOwner {
         caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, CAERUS_TOKEN), _tokenAddress);
    }

    function setTokenOwner(address _tokenOwner) public onlyOwner {
         caerusStorage.setAddress(keccak256(TOKEN_OWNER), _tokenOwner);
    }


    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }

}