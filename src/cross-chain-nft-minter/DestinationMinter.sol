// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */
contract DestinationMinter is CCIPReceiver {
    GhoToken ghoToken;

    event MintCallSuccessfull();

    constructor(address router, address ghoTokenAddress) CCIPReceiver(router) {
        ghoToken = GhoToken(ghoTokenAddress);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        (bool success, ) = address(ghoToken).call(message.data);
        require(success);
        emit MintCallSuccessfull();
    }

    function executeMint(address receiver, uint256 amount) external {
        bytes memory data = abi.encode(receiver, amount);
        address receiverFromData;
        uint256 amountFromData;
        (receiverFromData, amountFromData) = abi.decode(data, (address, uint256));
        GhoToken(ghoToken).mint(receiverFromData, amountFromData);
    }
}
