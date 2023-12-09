// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../ConnectorConnection.sol";
import "../Connector.sol";
import "../interface/IConnector.sol";
import "../interface/ICore.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Aave is ConnectorBuilder, ERC20{
 IERC20 public test;
 address connectorAddress;

    constructor(
        string memory name_,
        string memory symbol_,
        address test_
    ) ERC20(name_, symbol_) {
        test = IERC20(test_);
    }

    /// @notice user should have given set TEST token approval
    function mint(uint256 amount, address to) external {
        test.transferFrom(msg.sender, address(this), amount);
        PointOfConcern[] memory points = new PointOfConcern[](1);
        points[0].weightage = 5;
        IConnector(connectorAddress).updateCibilScore(msg.sender,points);
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        test.transfer(msg.sender, amount);
    }

    function createConnector() public override {
        Connector addr = new Connector();
        PointOfConcern[] memory points = new PointOfConcern[](4);
        points[0].weightage = 5;
        points[1].weightage = 7;
        points[2].weightage = -3;
        points[3].weightage = 1;
        IConnector(address(addr)).defineParams(points, 500);
        connectorAddress = address(addr);
    }   

    function registerConnector(address coreAddress) public override {
        // always call this after create connector in this demo file
        ICore(coreAddress).subscribeProtocolToConnector(address(this),1);
    }
}