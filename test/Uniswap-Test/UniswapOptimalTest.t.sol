// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import { Test, console } from "forge-std/Test.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { UniswapOptimal } from "src/Protocols/Uniswap/UniswapOptimal.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

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


contract UniswapOptimalTest is Test {
    UniswapOptimal uniswapoptimal;

    address public WHALE = 0x60FaAe176336dAb62e284Fe19B885B095d29fB7F; // Using DAI_WHALE
    uint256 public amount = 1000*(10**18);

    address public DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public pairaddress;

    function setUp() public{
        uniswapoptimal = new UniswapOptimal();
        // DAI - From Token
        // WETH -To Token
        pairaddress = uniswapoptimal.getPair(DAI, WETH);
        vm.startPrank(WHALE);
        IERC20(DAI).approve(address(uniswapoptimal),amount);
        vm.stopPrank();
    }

    function helper() public returns(uint256 lp,uint256 fromTokenAmt,uint256 toTokenAmt){
        lp = IERC20(pairaddress).balanceOf(address(uniswapoptimal));
        fromTokenAmt = IERC20(DAI).balanceOf(address(uniswapoptimal));
        toTokenAmt = IERC20(WETH).balanceOf(address(uniswapoptimal));
    }

    function testOptimalSwap() public {
        vm.startPrank(WHALE);
        uniswapoptimal.zap(DAI, WETH, amount);

        (uint256 lp, uint256 ftAmt, uint256 ttAmt) = helper();
        console.log("A", lp);
        console.log("B", ftAmt);
        console.log("C", ttAmt);
    }

    // for test to write
}



