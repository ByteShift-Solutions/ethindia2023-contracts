// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/examples/Uniswap.sol";

contract UniswapScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Uniswap uniswap = new Uniswap(address(0));

        vm.stopBroadcast();
    }
}
