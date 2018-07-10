pragma solidity ^0.4.19;

/**
 * @title Caerus Settings.
 * @dev The primary persistent storage for Caerus Assessments. 
 */
contract CaerusStorage {
    string constant internal CONTRACT_ADDRESS = "contract.address";

    mapping(bytes32 => address)    private addressStorage;
    mapping(bytes32 => int256)     private intStorage;
    mapping(bytes32 => uint256)    private uIntStorage;
    mapping(bytes32 => string)     private stringStorage;
    mapping(bytes32 => bytes)      private bytesStorage;
    mapping(bytes32 => bool)       private boolStorage;

    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setAddress(bytes32 _key, address _value) external onlyAllowed {
        addressStorage[_key] = _value;
    }

    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setUint(bytes32 _key, uint _value) external onlyAllowed {
        uIntStorage[_key] = _value;
    }
    
    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setInt(bytes32 _key, int _value) external onlyAllowed {
        intStorage[_key] = _value;
    }

    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setString(bytes32 _key, string _value) external onlyAllowed {
        stringStorage[_key] = _value;
    }

    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setBytes(bytes32 _key, bytes _value) external onlyAllowed {
        bytesStorage[_key] = _value;
    }
    
    /**
    * @dev Sets an value for a particular key.
    * @param _key key portion of the stored item.
    * @param _value value portion of the stored item.
    */
    function setBool(bytes32 _key, bool _value) external onlyAllowed {
        boolStorage[_key] = _value;
    }
    
    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteAddress(bytes32 _key) external onlyAllowed {
        delete addressStorage[_key];
    }

    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteUint(bytes32 _key) external onlyAllowed {
        delete uIntStorage[_key];
    }

    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteString(bytes32 _key) external onlyAllowed {
        delete stringStorage[_key];
    }

    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteBytes(bytes32 _key) external onlyAllowed {
        delete bytesStorage[_key];
    }
    
    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteBool(bytes32 _key) external onlyAllowed {
        delete boolStorage[_key];
    }
    
    /**
    * @dev Deletes an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function deleteInt(bytes32 _key) external onlyAllowed {
        delete intStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getAddress(bytes32 _key) external view returns (address) {
        return addressStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getUint(bytes32 _key) external view returns (uint) {
        return uIntStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getString(bytes32 _key) external view returns (string) {
        return stringStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getBytes(bytes32 _key) external view returns (bytes) {
        return bytesStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getBool(bytes32 _key) external view returns (bool) {
        return boolStorage[_key];
    }

    /**
    * @dev Gets an value for a particular key.
    * @param _key key portion of the stored item.
    */
    function getInt(bytes32 _key) external view returns (int) {
        return intStorage[_key];
    }

    constructor() public {
        // Set the main owner upon deployment
        boolStorage[keccak256("contract.owner", msg.sender)] = true;
    }

    modifier onlyAllowed() {
        // The owner and other contracts are only allowed to set the storage upon deployment to register the initial 
        // contracts/settings,  afterwards their direct access is disabled
        if (boolStorage[keccak256(CONTRACT_ADDRESS, "initialised")] == true) {
            // Make sure the access is permitted to only contracts in our Dapp
            require(addressStorage[keccak256(abi.encodePacked(CONTRACT_ADDRESS, msg.sender))] != 0x0);
        }
        _;
    }
}
