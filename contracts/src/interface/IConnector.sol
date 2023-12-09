// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

interface IConnector {

    // modifier should be implemented ( as a rule ) to make sure anything other than the get requests are only from "core" or the "registered protocols"
    struct PointOfConcern {
        uint256 variable;
        int256 weightage;
    }
    function defineParams(PointOfConcern[] calldata poc, uint256 baseScore) external;

    // checks if user was registered, else treats it as a user with base score ( defined in initialisation )
    function updateCibilScore(address user, PointOfConcern[] calldata thinkOfAVariableName) external returns(uint256);

    function getCibilScore(address user) external view;

    // override as public in implementation
    function calculateNewScore(uint256 x) external view;

    // from core
    function enterSubscriptionWhitelist() external;

    // from core
    function unsubscribe() external;

    // only owner for now, eventually governance
    function acceptSubscriptionRequest(uint256 subscriptionId) external;
}