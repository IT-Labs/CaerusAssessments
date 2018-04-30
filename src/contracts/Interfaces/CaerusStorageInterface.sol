pragma solidity ^0.4.19;


contract CaerusStorageInterface {
    
    function setAddress(bytes32 _key, address _value) external onlyAllowed;

    /// @param _key The key for the record
    function setUint(bytes32 _key, uint _value) external onlyAllowed;
    
    /// @param _key The key for the record
    function setInt(bytes32 _key, int _value) external onlyAllowed;

    /// @param _key The key for the record
    function setString(bytes32 _key, string _value) external onlyAllowed;

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes _value) external onlyAllowed;
    
    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value) external onlyAllowed;
    
    /// @param _key The key for the record
    function deleteAddress(bytes32 _key) external onlyAllowed;

    /// @param _key The key for the record
    function deleteUint(bytes32 _key) external onlyAllowed;

    /// @param _key The key for the record
    function deleteString(bytes32 _key) external onlyAllowed;

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key) external onlyAllowed;
    
    /// @param _key The key for the record
    function deleteBool(bytes32 _key) external onlyAllowed;
    
    /// @param _key The key for the record
    function deleteInt(bytes32 _key) external onlyAllowed;

    /// @param _key The key for the record
    function getAddress(bytes32 _key) external view returns (address);

    /// @param _key The key for the record
    function getUint(bytes32 _key) external view returns (uint);

    /// @param _key The key for the record
    function getString(bytes32 _key) external view returns (string);

    /// @param _key The key for the record
    function getBytes(bytes32 _key) external view returns (bytes);

    /// @param _key The key for the record
    function getBool(bytes32 _key) external view returns (bool);

    /// @param _key The key for the record
    function getInt(bytes32 _key) external view returns (int);

    /// @dev Only allow access from the latest version of a contract in the Caerus Assessments network after deployment
    modifier onlyAllowed() {        
        _;
    }
}