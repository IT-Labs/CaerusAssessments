pragma solidity ^0.4.19;


import "../../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";


contract CaerusTokenInterface is ERC20 {
    
    function spendToken(uint256 _tokens) public returns (bool);

}