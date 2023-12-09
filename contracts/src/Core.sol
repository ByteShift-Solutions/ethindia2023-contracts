// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {UD60x18, wrap} from "@prb/math/UD60x18.sol";
import "./interface/IConnector.sol";

contract Core is ERC721("score", "SCR") {

    struct User {
        uint256 id;
        uint256 nativeSecurity;
        mapping(address => uint256) erc20Security;
    }

    uint256 id = 1; // rename
    uint256 userId = 1; // rename
    mapping(uint256 => address) connectorId; // rename
    mapping(address => User) userInfo;
    mapping(address => uint256) protocolToConnector;
    mapping(address => bool) whitelistedTokens;

    modifier onlyRegisteredUser(address addr) {
        require(userInfo[addr].id != 0, "User not registered");
        _;
    }
    function aggregateScores(address user, uint256[] calldata ids) public returns (uint256) {
        uint length = ids.length;
        uint sum = 0;
        for (uint i = 0; i < length; i++ ) {
            // TODO: need interface
            require(connectorId[ids[i]] != address(0), "Invalid id");
            sum += IConnector(connectorId[ids[i]]).getCibilScore(user);
        }

        return sum / length;
    }

    function userRegistration() public {
        require(userInfo[msg.sender].id == 0, "already registered");
        User storage newUser = userInfo[msg.sender];
        newUser.id = userId++;
    }

    function depositSecurity() onlyRegisteredUser(msg.sender) public payable {
        uint256 value = msg.value;
        userInfo[msg.sender].nativeSecurity = value;
    }

    function depositSecurityWithERC20(uint256 amount, address tokenAddress) public {
        IERC20(tokenAddress).transferFrom( msg.sender, address(this), amount);
        userInfo[msg.sender].erc20Security[tokenAddress] = amount;
    }

    function whitelistAddress(address tokenAddress) external {
        whitelistedTokens[tokenAddress] = true;
    }

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
