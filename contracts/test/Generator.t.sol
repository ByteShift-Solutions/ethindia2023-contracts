// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {Test, console2 as console} from "forge-std/Test.sol";
import {Generator} from "../src/Generator.sol";

contract GeneratorTest is Test {
    Generator public generator;

    function setUp() public {
        generator = new Generator();
    }

    function test_naturalLog() public {
        console.log(generator.generateScore(343434.234343e18));
    }
}
