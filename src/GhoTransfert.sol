// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

// must give function to transfert Gho

contract GhoTransfert {
    address ghoAddress;
    address owner;

    constructor(address _ghoAddress) {
        ghoAddress = _ghoAddress;
        owner = msg.sender;
    }

    function transfertGho(address _receiver, uint256 _amount) external {
        require(msg.sender == owner, "Only owner can transfert Gho");
        GhoToken ghoToken = GhoToken(ghoAddress);
        ghoToken.transferFrom(msg.sender, _receiver, _amount);
    }

    function transfertGhoToContract(uint256 _amount) external {
        require(msg.sender == owner, "Only owner can transfert Gho");
        GhoToken ghoToken = GhoToken(ghoAddress);
        address _receiver = address(this);
        ghoToken.transferFrom(msg.sender, _receiver, _amount);
    }

}
