// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import { Test, console } from "forge-std/Test.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { Uniswap } from "src/Protocols/Uniswap/Uniswap.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract UniswapTest is Test {

// DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F"
// USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
// USDT = "0xdAC17F958D2ee523a2206206994597C13D831ec7"
// WETH = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
// WBTC = "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599"

// WETH_WHALE="0xF04a5cC80B1E94C69B48f5ee68a08CD2F09A7c3E"
// DAI_WHALE="0x60FaAe176336dAb62e284Fe19B885B095d29fB7F"
// USDC_WHALE="0xD6153F5af5679a75cC85D8974463545181f48772"
// USDT_WHALE="0x5754284f345afc66a98fbB0a0Afe71e0F007B949"
// WBTC_WHALE="0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8"

    Uniswap uniswap;
    address public WHALE = 0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8;
    uint256 public AMOUNT_IN = 100000000;
    uint256 public AMOUNT_OUT_MIN = 1;
    address public TOKEN_IN = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599; // WBTC
    address public TOKEN_OUT = 0x6B175474E89094C44Da98b954EedeAC495271d0F; // DAI
    address public user = makeAddr("user");

    function setUp() public {
        uniswap = new Uniswap();
        vm.startPrank(WHALE);
        IERC20(TOKEN_IN).approve(address(uniswap), AMOUNT_IN);
        vm.stopPrank();
    }

    function testshouldSwapToken() public {
        vm.startPrank(WHALE);
        uniswap.swap(TOKEN_IN,TOKEN_OUT, AMOUNT_IN, AMOUNT_OUT_MIN, user);
        vm.stopPrank();

        console.log("Amount in", AMOUNT_IN);
        console.log("Amount out", IERC20(TOKEN_OUT).balanceOf(user));

    }
}

// const BN = require("bn.js");
// const { sendEther } = require("./util");
// const { DAI, WBTC, WBTC_WHALE } = require("./config");

// const IERC20 = artifacts.require("IERC20");
// const TestUniswap = artifacts.require("TestUniswap");

// contract("TestUniswap", (accounts) => {
//   const WHALE = WBTC_WHALE;
//   const AMOUNT_IN = 100000000;
//   const AMOUNT_OUT_MIN = 1;
//   const TOKEN_IN = WBTC;
//   const TOKEN_OUT = DAI;
//   const TO = accounts[0];

//   let testUniswap;
//   let tokenIn;
//   let tokenOut;
//   beforeEach(async () => {
//     tokenIn = await IERC20.at(TOKEN_IN);
//     tokenOut = await IERC20.at(TOKEN_OUT);
//     testUniswap = await TestUniswap.new();

//     // make sure WHALE has enough ETH to send tx
//     // await sendEther(web3, accounts[0], WHALE, 1);
//     await tokenIn.approve(testUniswap.address, AMOUNT_IN, { from: WHALE });
//   });

//   it("should pass", async () => {
//     await testUniswap.swap(
//       tokenIn.address,
//       tokenOut.address,
//       AMOUNT_IN,
//       AMOUNT_OUT_MIN,
//       TO,
//       {
//         from: WHALE,
//       }
//     );

//     console.log(`in ${AMOUNT_IN}`);
//     console.log(`out ${await tokenOut.balanceOf(TO)}`);
//   });
// });
