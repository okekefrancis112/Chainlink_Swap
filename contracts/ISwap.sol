
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./IERC20.sol";
import "./Pricefeed.sol";


interface ISwap {
    // function createOrder(address _fromToken, address _toToken, uint amountIn, uint DesiredAmountOut) external;

    // function executeOrder(uint _ID) external;

    function swap(uint _amount1) external;

    function transferRate(int _iAmount) external view returns (int256);
}
