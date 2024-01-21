// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

contract Faucet {
    GhoToken public ghoToken;

    constructor(GhoToken _ghoToken) {
        ghoToken = _ghoToken;
    }

    function mintGho() public {
        ghoToken.mint(msg.sender, 10 * 10 ** 18); // Mint 10 GHO tokens to the caller
    }
}
