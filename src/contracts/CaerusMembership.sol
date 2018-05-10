pragma solidity ^0.4.19;


import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./CaerusBase.sol";
import "./Interfaces/CaerusTokenInterface.sol";


contract CaerusMembership is CaerusBase {
    using SafeMath for uint256;
    CaerusTokenInterface internal caerusToken = CaerusTokenInterface(0);

    function monthlyPaymentJobSeeker() external {
        monthlyPayment(RATE_JOB_SEEKER);
    }

    function monthlyPaymentRecruter() external {
        monthlyPayment(RATE_RECRUTER);
    }

    function recurringPaymentJobSeeker(uint _months) external {
        recurringPayment(RATE_JOB_SEEKER, _months);
    }

    function recurringPaymentRecruter(uint _months) external {
        recurringPayment(RATE_RECRUTER, _months);
    }
    
    function recurringPaymentJobSeekerTokenTransfer(address _from) external onlyAllowedUsers returns (bool) {
        return recurringPaymentTokenTransfer(RATE_JOB_SEEKER, _from);
    }
    
    function recurringPaymentRecruterTokenTransfer(address _from) external onlyAllowedUsers returns (bool) {
        return recurringPaymentTokenTransfer(RATE_RECRUTER, _from);
    }

    function recurringPaymentCancel() external {
        setTokenInstance();
        caerusToken.approve(getOwnerAddress(), 0);
    }

    function monthlyPayment(string _rateConstant) private {
        setTokenInstance();
        caerusToken.spendToken(getRate(_rateConstant));
    }

    function recurringPayment(string _rateConstant, uint256 _months) private {
        require(_months > 1);
        setTokenInstance();
        uint256 allowance =  _months.sub(1).mul(getRate(_rateConstant));

        caerusToken.approve(getOwnerAddress(), allowance);
        monthlyPayment(_rateConstant);
    }
    
    function recurringPaymentTokenTransfer(string _rateConstant, address _from) private returns (bool) {
        require(_from != address(0));
        setTokenInstance();
        return caerusToken.transferFrom(_from, getOwnerAddress(), getRate(_rateConstant));
    }

    function getRate(string _rateConstant) private view  returns (uint256) {
        return caerusStorage.getUint(keccak256(_rateConstant));
    }

    function getOwnerAddress() private view returns (address) {
        return caerusStorage.getAddress(keccak256(TOKEN_OWNER));
    }

    function setTokenInstance() private {
        caerusToken = CaerusTokenInterface(getTokenAddress());
    }

    constructor(address _caerusStorage) public CaerusBase(_caerusStorage) {
    }    
}