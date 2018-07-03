pragma solidity ^0.4.19;


import "./CaerusBase.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

/**
 * @title Caerus Settings.
 * @dev Implementation of the Caerus Settings contract that configures the Caerus Storage to have all needed data. 
 */
contract CaerusSettings is CaerusBase {
    event UserAllowedEvent(
        address indexed _userAddress,
        bool _value
    );

    event ContractAddressChangedEvent(
        address indexed _contractAddress,
        string _value
    );

    event StorageInitializedEvent();

    /**
    * @dev Sets an address in the allowed list of users - used in onlyAllowedUsers modifier.
    * @param _address user address.
    */
    function allowUser(address _address) public onlyOwner {
        caerusStorage.setAddress(keccak256(USER_ADDRESS, _address), _address);
        emit UserAllowedEvent(_address, true);
    }

    /**
    * @dev Removes an address in the allowed list of users - used in onlyAllowedUsers modifier.
    * @param _address user address.
    */
    function disallowUser(address _address) public onlyOwner {
        caerusStorage.deleteAddress(keccak256(USER_ADDRESS, _address));
        emit UserAllowedEvent(_address, false);
    }

    /**
    * @dev Sets a contract info in Caerus Storage so that contract address can be used by other contracts and allows access of the contract to the storage.
    * @param _contract Contract name.
    * @param _address Contract address.
    */
    function setContractAddress(string _contract, address _address) public onlyOwner {
        caerusStorage.setBool(keccak256(CONTRACT_ADDRESS, _address), true);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _contract), _address);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _address), _address);
        emit ContractAddressChangedEvent(_address, _contract);
    }

    /**
    * @dev Sets a CaerusToken related info to the storage.
    * @param _tokenAddress CaerusToken address.
    * @param _tokenOwner CaerusToken owner address.
    */
    function setToken(address _tokenAddress, address _tokenOwner) public onlyOwner {
         caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, CAERUS_TOKEN), _tokenAddress);
         caerusStorage.setAddress(keccak256(TOKEN_OWNER), _tokenOwner);
    }


    /**
    * @dev Sets a Caerus storage as intiated so that only other contracts can access it and modify its content.
    */
    function setStorageInitialized() public onlyOwner {
         caerusStorage.setBool(keccak256(CONTRACT_ADDRESS, "initialised"), true);
         emit StorageInitializedEvent();
    }


    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }

}