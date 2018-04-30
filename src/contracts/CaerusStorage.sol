pragma solidity ^0.4.19;


import "./Interfaces/CaeruStorageInterface.sol";


/// @title The primary persistent storage for Caerus Assessments
contract CaeruStorage is CaeruStorageInterface {

    mapping(bytes32 => address)    private addressStorage;
    mapping(bytes32 => int256)     private intStorage;
    mapping(bytes32 => uint256)    private uIntStorage;
    mapping(bytes32 => string)     private stringStorage;
    mapping(bytes32 => bytes)      private bytesStorage;
    mapping(bytes32 => bool)       private boolStorage;

    /// @param _key The key for the record
    function setAddress(bytes32 _key, address _value) external onlyAllowed {
        addressStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint(bytes32 _key, uint _value) external onlyAllowed {
        uIntStorage[_key] = _value;
    }
    
    /// @param _key The key for the record
    function setInt(bytes32 _key, int _value) external onlyAllowed {
        intStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setString(bytes32 _key, string _value) external onlyAllowed {
        stringStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes _value) external onlyAllowed {
        bytesStorage[_key] = _value;
    }
    
    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value) external onlyAllowed {
        boolStorage[_key] = _value;
    }
    
    /// @param _key The key for the record
    function deleteAddress(bytes32 _key) external onlyAllowed {
        delete addressStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUint(bytes32 _key) external onlyAllowed {
        delete uIntStorage[_key];
    }

    /// @param _key The key for the record
    function deleteString(bytes32 _key) external onlyAllowed {
        delete stringStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key) external onlyAllowed {
        delete bytesStorage[_key];
    }
    
    /// @param _key The key for the record
    function deleteBool(bytes32 _key) external onlyAllowed {
        delete boolStorage[_key];
    }
    
    /// @param _key The key for the record
    function deleteInt(bytes32 _key) external onlyAllowed {
        delete intStorage[_key];
    }

    /// @param _key The key for the record
    function getAddress(bytes32 _key) external view returns (address) {
        return addressStorage[_key];
    }

    /// @param _key The key for the record
    function getUint(bytes32 _key) external view returns (uint) {
        return uIntStorage[_key];
    }

    /// @param _key The key for the record
    function getString(bytes32 _key) external view returns (string) {
        return stringStorage[_key];
    }

    /// @param _key The key for the record
    function getBytes(bytes32 _key) external view returns (bytes) {
        return bytesStorage[_key];
    }

    /// @param _key The key for the record
    function getBool(bytes32 _key) external view returns (bool) {
        return boolStorage[_key];
    }

    /// @param _key The key for the record
    function getInt(bytes32 _key) external view returns (int) {
        return intStorage[_key];
    }

     /// @dev constructor
    constructor() public {
        // Set the main owner upon deployment
        boolStorage[keccak256("contract.owner", msg.sender)] = true;
    }

    /// @dev Only allow access from the latest version of a contract in the Caerus Assessments network after deployment
    modifier onlyAllowed() {
        // The owner and other contracts are only allowed to set the storage upon deployment to register the initial 
        // contracts/settings,  afterwards their direct access is disabled
        if (boolStorage[keccak256("contract.storage.initialised")] == true) {
            // Make sure the access is permitted to only contracts in our Dapp
            require(addressStorage[keccak256("contract.address", msg.sender)] != 0x0);
        }
        _;
    }
}
