// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

struct PointOfConcern {
    uint256 variable;
    int256 weightage;
}

interface IConnector {
    // modifier should be implemented ( as a rule ) to make sure anything other than the get requests are only from "core" or the "registered protocols"
    function defineParams(
        PointOfConcern[] calldata poc,
        uint256 baseScore
    ) external;

    // checks if user was registered, else treats it as a user with base score ( defined in initialisation )
    function updateCibilScore(
        address user,
        PointOfConcern[] calldata poc
    ) external returns (uint256);

    function getCibilScore(address user) external view returns (uint256);

    // override as public in implementation
    function calculateNewScore(uint256 x) external;

    // from core
    function enterSubscriptionWhitelist() external;

    // from core
    function unsubscribe() external;

    // only owner for now, eventually governance
    function acceptSubscriptionRequest(uint256 subscriptionId) external;
}
