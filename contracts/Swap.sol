
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./IERC20.sol";
import "./Pricefeed.sol";

// contract Swap is TestChainlink {
//     IERC20 token;
//     AggregatorV3Interface private s_priceFeed;

//     struct Order{
//         address _to;
//         address fromToken;
//         address toToken;
//         uint amountIN;
//         uint amountOut;
//         // int rate;
//         bool status;
//     }

//     mapping(uint => Order) _order;
//     uint ID = 1;

//     function createOrder(address _fromToken, address _toToken, uint amountIn, uint DesiredAmountOut) public {
//         require(IERC20(_fromToken).transferFrom(msg.sender, address(this),amountIn), "transfer Failed");
//         Order storage OD = _order[ID];
//         OD.fromToken = _fromToken;
//         OD.toToken = _toToken;
//         OD.amountIN = amountIn;
//         OD.amountOut = DesiredAmountOut;
//         OD.status = true;

//         ID++;
//     }

//     function executeOrder(uint _ID) public {
//         Order storage OD = _order[_ID];
//         assert(OD.status);


//         uint _amountOUT = OD.amountOut;
//         require(IERC20(OD.toToken).transferFrom(msg.sender, address(this),_amountOUT), "transfer Failed");
//         OD.status = false;
//         IERC20(OD.fromToken).transfer(msg.sender, OD.amountIN);
//         IERC20(OD.toToken).transfer(OD._to, _amountOUT);
//     }

//     function transferRate() public view returns (int256) {
//         int getRate = getConversionRate(2);
//         return(getRate);
//     }


// }

contract Swap is Pricefeed {
    IERC20 public token1;
    address public owner1;
    uint public amount1;
    IERC20 public token2;
    address public owner2;
    uint public amount2;

    constructor(
        address _token1,
        address _owner1,
        address _token2,
        address _owner2
    ) {
        token1 = IERC20(_token1);
        owner1 = _owner1;
        // amount1 = _amount1;
        token2 = IERC20(_token2);
        owner2 = _owner2;
        // amount2 = _amount2;
    }

    event Swapping(uint _amount1);

    function swap(uint _amount1) public {
        amount1 = _amount1;
        // amount2 = _amount2;
        require(msg.sender == owner1 || msg.sender == owner2, "Not authorized");
        require(
            token1.allowance(owner1, address(this)) >= amount1,
            "Token 1 allowance too low"
        );
        // require(
        //     token2.allowance(owner2, address(this)) >= amount2,
        //     "Token 2 allowance too low"
        // );

        uint rate = uint(transferRate(int(amount1)));
        // uint transferrable1 = amount1;
        uint transferrable2 = amount2 * rate;

        // _safeTransferFrom(token1, owner1, owner2, amount1);
        // _safeTransferFrom(token2, owner2, owner1, transferrable1);
        // _safeTransferFrom(token2, owner2, owner1, amount2);
        _safeTransferFrom(token2, owner2, owner1, transferrable2);

        emit Swapping(_amount1);
    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }

    function transferRate(int _iAmount) public view returns (int256) {
        int getRate = getConversionRate(_iAmount);
        return(getRate);
    }
}
