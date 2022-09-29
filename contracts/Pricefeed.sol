// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./IERC20.sol";

contract Pricefeed {
  AggregatorV3Interface internal priceFeed;

  // address _to;
  // address fromToken;
  // address toToken;
  // uint amountIN;
  // uint amountOut;

  constructor() {
    // 1INCH / USD
    priceFeed = AggregatorV3Interface(0xc929ad75B72593967DE83E7F7Cda0493458261D9);
  }

  function getLatestPrice() public view returns (int) {
    (, int price, , , ) = priceFeed.latestRoundData();

    // 1INCH/USD rate in 18 digit
    return (price * 10000000000);
  }

  function getConversionRate(int256 inchAmount) public view returns (int256) {
    int256 inchPrice = getLatestPrice();
    int256 inchAmountInUsd = (inchPrice * inchAmount) / 1000000000000000000;
    // the actual 1INCH/USD conversation rate, after adjusting the extra 0s.
    return inchAmountInUsd;
  }

}



// pragma solidity ^0.8.8;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// library PriceConverter {
//   function getPrice(AggregatorV3Interface priceFeed)
//     internal
//     view
//     returns (uint256)
//   {
//     (, int256 answer, , , ) = priceFeed.latestRoundData();
//     // ETH/USD rate in 18 digit
//     return uint256(answer * 10000000000);
//   }

//   // 1000000000
//   // call it get fiatConversionRate, since it assumes something about decimals
//   // It wouldn't work for every aggregator
//   function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed)
//     internal
//     view
//     returns (uint256)
//   {
//     uint256 ethPrice = getPrice(priceFeed);
//     uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
//     // the actual ETH/USD conversation rate, after adjusting the extra 0s.
//     return ethAmountInUsd;
//   }
// }