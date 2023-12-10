// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IConnector} from "./interface/IConnector.sol";
import {SVG} from "./SVG.sol";
import {UD60x18, wrap} from "@prb/math/UD60x18.sol";

struct User {
    uint256 id;
    uint256 nativeSecurity;
    mapping(address => uint256) erc20Security;
}
struct Score {
    uint256 connectorId;
    uint256 score;
}

contract Core is ERC721("score", "SCR") {
    uint256 id = 1; // rename
    uint256 userId = 1; // rename
    mapping(uint256 => address) public connectorId; // rename
    mapping(address => User) userInfo;
    mapping(address => uint256) protocolToConnector;
    mapping(address => bool) whitelistedTokens;

    modifier onlyRegisteredUser(address addr) {
        require(userInfo[addr].id != 0, "User not registered");
        _;
    }

    function aggregateScores(
        address user,
        uint256[] calldata ids
    ) public view returns (uint256 score) {
        uint256 length = ids.length;
        uint256 score;
        for (uint256 i = 0; i < length; i++) {
            address connector = connectorId[ids[i]];
            score += IConnector(connector).getCibilScore(user);
        }
        return score / length;
    }

    function userRegistration() public {
        require(userInfo[msg.sender].id == 0, "already registered");
        _mint(msg.sender, ++userId);
        User storage newUser = userInfo[msg.sender];
        newUser.id = userId;
    }

    function depositSecurity() public payable onlyRegisteredUser(msg.sender) {
        uint256 value = msg.value;
        userInfo[msg.sender].nativeSecurity = value;
    }

    function depositSecurityWithERC20(
        uint256 amount,
        address tokenAddress
    ) public {
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
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

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        address user = _ownerOf(_tokenId);
        if (user == address(0)) return "";
        uint256 aggregateScore = 0;
        Score[] memory scores = new Score[](id);
        for (uint256 i = 0; i < id; i++) {
            uint256 _score = IConnector(connectorId[i]).getCibilScore(user);
            scores[i] = Score(i, _score);
            aggregateScore += _score;
        }
        return
            SVG.generateSVG(
                user,
                userInfo[user].nativeSecurity,
                aggregateScore,
                scores
            );
    }
}
