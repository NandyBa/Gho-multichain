// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

contract GhoTokenTest is Test {
    GhoToken ghoToken;

    function setUp() public {
        ghoToken = new GhoToken(address(this));
    }

    function test_totalSupply() public {
        assertEq(ghoToken.totalSupply(), 0);
    }

}
