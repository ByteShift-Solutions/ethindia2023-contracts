// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Test, console2 as console} from "forge-std/Test.sol";
import {Generator} from "../src/Generator.sol";
import {PointOfConcern} from "../src/interface/IConnector.sol";

contract GeneratorTest is Test {
    function test_naturalLog() public {
        // PointOfConcern[] memory poc = [PointOfConcern(1, 1)];
        // console.log(Generator.generateScore());
    }
}
