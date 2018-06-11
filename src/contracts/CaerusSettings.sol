pragma solidity ^0.4.19;


import "./CaerusBase.sol";
import "../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

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

    function allowUser(address _address) public onlyOwner {
        caerusStorage.setAddress(keccak256(USER_ADDRESS, _address), _address);
        emit UserAllowedEvent(_address, true);
    }

    function disallowUser(address _address) public onlyOwner {
        caerusStorage.deleteAddress(keccak256(USER_ADDRESS, _address));
        emit UserAllowedEvent(_address, false);
    }

    function setContractAddress(string _contract, address _address) public onlyOwner {
        caerusStorage.setBool(keccak256(CONTRACT_ADDRESS, _address), true);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _contract), _address);
        caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, _address), _address);
        emit ContractAddressChangedEvent(_address, _contract);
    }

    function setToken(address _tokenAddress, address _tokenOwner) public onlyOwner {
         caerusStorage.setAddress(keccak256(CONTRACT_ADDRESS, CAERUS_TOKEN), _tokenAddress);
         caerusStorage.setAddress(keccak256(TOKEN_OWNER), _tokenOwner);
    }

    function setStorageInitialized() public onlyOwner {
         caerusStorage.setBool(keccak256(CONTRACT_ADDRESS, "initialised"), true);
         emit StorageInitializedEvent();
    }


    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }

}