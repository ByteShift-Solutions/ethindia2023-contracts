// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Core is ERC721("score", "SCR") {
    uint256 id = 1;
    mapping(uint256 => address) connectorId;
    mapping(address => bool) user;
    mapping(address => uint256) protocolToConnector;

    function aggregateScores(address user, uint256[] calldata ids) public {
        uint length = ids.length;
        for (uint i = 0; i < length; i++) {
            // TODO: need interface
        }
    }

    function userRegistration() public {}

    function depositSecurity() public {}

    function depositSecurityWithERC20() public {}

    function registerConnector(address connectorAddr) public {
        // TODO: implement interface sanity check here
        connectorId[id++] = connectorAddr;
    }

    function subscribeProtocolToConnector(
        address protocolAddress,
        uint256 targetConnectorId
    ) public {
        require(
            targetConnectorId == protocolToConnector[protocolAddress],
            "Invalid connector"
        );
        protocolToConnector[protocolAddress] = 0;
    }

    function unsubscribeProtocolFromConnector(
        address protocolAddress,
        uint256 targetConnectorId
    ) public {
        protocolToConnector[protocolAddress] = targetConnectorId;
    }
}
