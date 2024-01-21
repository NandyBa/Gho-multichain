// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {Withdraw} from "./utils/Withdraw.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {IGhoToken} from "./interface/IGhoToken.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

contract MultiChainFacilitator is Withdraw, CCIPReceiver {
    address Gho_Address;

    enum PayFeesIn {
        Native,
        LINK
    }

    address immutable i_link;

    event MessageSent(bytes32 messageId);
    event MintCallSuccessfull();

    constructor(
        address router,
        address link,
        address _Gho_Address
    ) CCIPReceiver(router) {
        Gho_Address = _Gho_Address;
        i_link = link;
    }

    receive() external payable {}

    function multiChainTransfert(
        uint64 destinationChainSelector,
        address receiver,
        PayFeesIn payFeesIn,
        uint256 amount
    ) external {
        IGhoToken GHOContract = IGhoToken(Gho_Address);
        require(
            GHOContract.transferFrom(msg.sender, address(this), amount),
            "can't transfert"
        );
        uint256 balanceBefore = GHOContract.balanceOf(address(this));
        GHOContract.burn(amount);
        uint256 balanceAfter = GHOContract.balanceOf(address(this));
        require((balanceBefore - balanceAfter) == amount, "can't burn");
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(receiver),
            data: abi.encode(msg.sender, amount),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: "",
            feeToken: payFeesIn == PayFeesIn.LINK ? i_link : address(0)
        });
        address router = getRouter();

        uint256 fee = IRouterClient(router).getFee(
            destinationChainSelector,
            message
        );

        bytes32 messageId;

        if (payFeesIn == PayFeesIn.LINK) {
            LinkTokenInterface(i_link).approve(router, fee);
            messageId = IRouterClient(router).ccipSend(
                destinationChainSelector,
                message
            );
        } else {
            messageId = IRouterClient(router).ccipSend{value: fee}(
                destinationChainSelector,
                message
            );
        }

        emit MessageSent(messageId);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        bytes memory data = message.data;
        address receiver;
        uint256 amount;
        (receiver, amount) = abi.decode(data, (address, uint256));
        GhoToken(Gho_Address).mint(receiver, amount);
        emit MintCallSuccessfull();
    }
}
