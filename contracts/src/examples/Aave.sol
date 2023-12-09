// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../ConnectorConnection.sol";
import "../Connector.sol";
import "../interface/IConnector.sol";
import "../interface/ICore.sol";

contract Aave is ConnectorBuilder{

    mapping(address => uint256) public balances;

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount should be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount should be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function createConnector() public override {
        Connector addr = new Connector();
        PointOfConcern[] memory points = new PointOfConcern[](4);
        points[0].weightage = 5;
        points[1].weightage = 7;
        points[2].weightage = -3;
        points[3].weightage = 1;
        IConnector(address(addr)).defineParams(points, 500);
    }   

    function registerConnector(address coreAddress) public override {
        // always call this after create connector in this demo file
        ICore(coreAddress).subscribeProtocolToConnector(address(this),1);
    }
}