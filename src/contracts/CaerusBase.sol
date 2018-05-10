pragma solidity ^0.4.19;


import "./Interfaces/CaerusStorageInterface.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";


contract CaerusBase is Destructible {

    CaerusStorageInterface internal caerusStorage = CaerusStorageInterface(0);
    string constant internal USER_ADDRESS = "user.address";
    string constant internal CONTRACT_ADDRESS = "contract.address";
    string constant internal RATE_RECRUTER = "rate.recruter";
    string constant internal RATE_JOB_SEEKER = "rate.jobseeker";
    string constant internal TOKEN_OWNER = "token.owner";

    modifier onlyAllowedUsers() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(caerusStorage.getAddress(keccak256(USER_ADDRESS, msg.sender)) != 0x0);
        _;
    }

    function getTokenAddress() public view returns (address) {
        return caerusStorage.getAddress(keccak256(CONTRACT_ADDRESS, "caerus.token"));
    }

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorageInterface(_caerusStorage);
    }

}