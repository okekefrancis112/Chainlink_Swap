import { ethers } from "hardhat";
const helpers = require("@nomicfoundation/hardhat-network-helpers");

async function main() {
    
    const INCHAddress ="0xc929ad75B72593967DE83E7F7Cda0493458261D9";
    const USDCAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    const amountOut = 5000;

    const USDCHolder = "0xe0C415659b3858487eFF5Cbac8C8ff53B13545c8";
    await helpers.impersonateAccount(USDCHolder);
    const impersonatedSigner = await ethers.getSigner(USDCHolder);

    const USDC = await ethers.getContractAt("IERC20", USDCAddress, impersonatedSigner);

    const INCH = await ethers.getContractAt("IERC20", INCHAddress);


    const Swap = await ethers.getContractFactory("Swap");
    const swap = await Swap.deploy(USDCAddress, USDCHolder, INCHAddress, USDCHolder);
    const Route = swap.address

    await USDC.approve(Route, amountOut);

    const ROUTER = await ethers.getContractAt("ISwap", Route, impersonatedSigner);

    //   bal
    const USDCBal = await USDC.balanceOf(USDCHolder);
    const inchBal = await INCH.balanceOf(USDCHolder);

    console.log("Eth before swap", USDCBal);
    console.log("DAI before swap", inchBal);


    await ROUTER.swap(2);
    
      const USDCBalAfter = await USDC.balanceOf(USDCHolder);
      const INCHBalAfter = await INCH.balanceOf(USDCHolder);
  
      console.log("balance after swap", USDCBalAfter, INCHBalAfter);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });