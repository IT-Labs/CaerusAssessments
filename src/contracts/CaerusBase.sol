pragma solidity ^0.4.19;


import "./CaerusStorage.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";


contract CaerusBase is Destructible {

    CaerusStorage internal caerusStorage;
    string constant internal USER_ADDRESS = "user.address";
    string constant internal CONTRACT_ADDRESS = "contract.address";
    string constant internal TOKEN_OWNER = "token.owner";
    string constant internal CAERUS_TOKEN = "caerus.token";

    modifier onlyAllowedUsers() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(caerusStorage.getAddress(keccak256(USER_ADDRESS, msg.sender)) != 0x0);
        _;
    }

    function getTokenAddress() internal view returns (address) {
        return caerusStorage.getAddress(keccak256(CONTRACT_ADDRESS, CAERUS_TOKEN));
    }

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorage(_caerusStorage);
    }

}