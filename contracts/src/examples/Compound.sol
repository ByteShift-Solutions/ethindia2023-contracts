// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../ConnectorConnection.sol";
import "../Connector.sol";
import "../interface/IConnector.sol";
import "../interface/ICore.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Compound is ConnectorSubscriber, ERC20 {
    IERC20 public test;
    address connectorAddr;

    constructor(
        string memory name_,
        string memory symbol_,
        IERC20 test_
    ) ERC20(name_, symbol_) {
        test = test_;
    }

    /// @notice user should have given set TEST token approval
    function mint(uint256 amount, address to) external {
        test.transferFrom(msg.sender, address(this), amount);
        PointOfConcern[] memory points = new PointOfConcern[](1);
        points[0].weightage = 5;
        IConnector(connectorAddr).updateCibilScore(msg.sender, points);
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        test.transfer(msg.sender, amount);
    }

    function wrapperSubscribe(address _coreAddress, uint256 id) public {
        subscribeToConnector(id);
        connectorAddr = _coreAddress;
    }

    // to be called after aave connector creation
    function subscribeToConnector(uint256 id) public override {
        address connector = ICore(connectorAddr).connectorId(id);
        IConnector(connector).enterSubscriptionWhitelist();
    }
}
