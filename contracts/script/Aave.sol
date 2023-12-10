// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/examples/Aave.sol";
import "../src/mocks/mockToken.sol";

contract AaveScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        MockToken token = new MockToken("DAI", "DAI");
        Aave aave = new Aave("Aave", "Aave", address(token));

        vm.stopBroadcast();
    }
}
