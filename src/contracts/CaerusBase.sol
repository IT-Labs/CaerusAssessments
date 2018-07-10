pragma solidity ^0.4.19;


import "./CaerusStorage.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

/**
 * @title Caerus Base.
 * @dev Implementation of the Caerus Base contract that hold constants and modifiers that are used by other contracts.
 */
contract CaerusBase is Destructible {

    CaerusStorage internal caerusStorage;
    string constant internal USER_ADDRESS = "user.address";
    string constant internal CONTRACT_ADDRESS = "contract.address";
    string constant internal TOKEN_OWNER = "token.owner";
    string constant internal CAERUS_TOKEN = "caerus.token";

    modifier onlyAllowedUsers() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(caerusStorage.getAddress(getHashAddress(USER_ADDRESS, msg.sender)) != 0x0);
        _;
    }

    function getTokenAddress() internal view returns (address) {
        return caerusStorage.getAddress(getHashString(CONTRACT_ADDRESS, CAERUS_TOKEN));
    }

    function getHashString(string item, string itemString) pure internal returns (bytes32) {
        return keccak256(abi.encodePacked(item, itemString));
    }

    function getHashAddress(string item, address itemAddress) pure internal returns (bytes32) {
        return keccak256(abi.encodePacked(item, itemAddress));
    }

    constructor(address _caerusStorage) public {
        caerusStorage = CaerusStorage(_caerusStorage);
    }

}