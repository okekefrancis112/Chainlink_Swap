require("dotenv").config({ path: ".env" });
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
require("@nomiclabs/hardhat-ethers")

import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";
import { network } from "hardhat";


const config: HardhatUserConfig = {
  solidity: "0.8.9",

  networks: {
    hardhat: {
      forking: {
        url: "https://mainnet.infura.io/v3/965a992142e64206ad4e67bd922124af",
        //@ts-ignore
        // blockGasLimit: 200000000000,
        // gasPrice: 80000000000,
      }
    },
  }
};

export default config;