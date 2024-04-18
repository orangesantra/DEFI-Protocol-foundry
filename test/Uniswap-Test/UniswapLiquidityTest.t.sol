// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import { Test, console } from "forge-std/Test.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { UniswapLiquidity } from "src/Protocols/Uniswap/UniswapLiquidity.sol";
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


contract UniswapLiquidityTest is Test {
    UniswapLiquidity uniswapLiquidity;

    address public user = makeAddr("user");
    address public TOKEN_A = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public TOKEN_A_WHALE = 0xF04a5cC80B1E94C69B48f5ee68a08CD2F09A7c3E;
    address public TOKEN_B = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public TOKEN_B_WHALE = 0x60FaAe176336dAb62e284Fe19B885B095d29fB7F;
    uint256 public TOKEN_A_AMOUNT = 10**18;
    uint256 public TOKEN_B_AMOUNT = 10**18;

    function setUp() public{
        uniswapLiquidity = new UniswapLiquidity();

        vm.startPrank(TOKEN_A_WHALE);
        IERC20(TOKEN_A).transfer(user,TOKEN_A_AMOUNT);
        vm.stopPrank();

        vm.startPrank(TOKEN_B_WHALE);
        IERC20(TOKEN_B).transfer(user,TOKEN_B_AMOUNT);
        vm.stopPrank();

        vm.startPrank(user);
        IERC20(TOKEN_A).approve(address(uniswapLiquidity),TOKEN_A_AMOUNT);
        IERC20(TOKEN_B).approve(address(uniswapLiquidity),TOKEN_B_AMOUNT);
        vm.stopPrank();
    }

    function testaddingLiquidityAndRemovealso() public{
        vm.prank(user);
        uniswapLiquidity.addLiquidity(address(TOKEN_A), address(TOKEN_B), TOKEN_A_AMOUNT, TOKEN_B_AMOUNT);
        console.log("Before");
        console.log("Amount_A",IERC20(TOKEN_A).balanceOf(user));
        console.log("Amount_A",IERC20(TOKEN_A).balanceOf(address(uniswapLiquidity)));
        uniswapLiquidity.removeLiquidity(address(TOKEN_A),address(TOKEN_B));
        console.log("After");
        console.log("Amount_A",IERC20(TOKEN_A).balanceOf(user));
        console.log("Amount_A",IERC20(TOKEN_A).balanceOf(address(uniswapLiquidity)));
    }

    // moretesttowrite
}


