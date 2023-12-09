// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {AccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";
import {IConnector, PointOfConcern} from "./interface/IConnector.sol";
import {Generator} from "./Generator.sol";

error OnlyCore();
error OnlyCoreOrProtocol();

// extens interface
contract Connector is IConnector, AccessControlEnumerable {
    // code to define the equation concerned
    // code to interact with the generator library
    // and update the scores
    // interaction interface for the core ( aggregator )

    bytes32 public constant REGISTERED_PROTOCOL =
        keccak256("REGISTERED_PROTOCOL");
    bytes32 public constant GOVERNANCE = keccak256("GOVERNANCE");
    address public core;

    PointOfConcern[] public poc;
    uint256 public baseScore;

    mapping(address user => PointOfConcern[] userScore) public userScores;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(GOVERNANCE, msg.sender);
        core = msg.sender;
    }

    function updateCore(address _core) external onlyRole(GOVERNANCE) {
        core = _core;
    }

    modifier onlyCore() {
        if (msg.sender != core) revert OnlyCore();
        _;
    }

    modifier onlyCoreOrProtocol() {
        if (msg.sender != core || !hasRole(REGISTERED_PROTOCOL, msg.sender))
            revert OnlyCoreOrProtocol();
        _;
    }

    function defineParams(
        PointOfConcern[] calldata _poc,
        uint256 _baseScore
    ) external override onlyRole(GOVERNANCE) {
        uint256 len = _poc.length;
        for (uint i; i < len; i++) {
            poc[i] = _poc[i];
        }
        baseScore = _baseScore;
    }

    function updateCibilScore(
        address _user,
        PointOfConcern[] calldata _poc
    ) external returns (uint256) {
        uint256 len = _poc.length;
        for (uint256 i; i < len; i++) {
            PointOfConcern memory _poc = PointOfConcern(
                _poc[i].variable,
                _poc[i].weightage
            );
            userScores[_user][i] = _poc;
        }
    }

    function getCibilScore(
        address _user
    ) external view override returns (uint256) {
        PointOfConcern[] memory _userScore = userScores[_user];
        return Generator.generateScore(_userScore);
    }

    function calculateNewScore(uint256 x) external {}

    // from core
    function enterSubscriptionWhitelist() external {}

    // from core
    function unsubscribe() external {}

    // only owner for now, eventually governance
    function acceptSubscriptionRequest(uint256 subscriptionId) external {}
}
