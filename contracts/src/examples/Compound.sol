// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../ConnectorConnection.sol";
import "../Connector.sol";
import "../interface/IConnector.sol";
import "../interface/ICore.sol";

contract Compound is ConnectorSubscriber{

    address coreAddress;
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

    function wrapperSubscribe(address _coreAddress, uint256 id) public {
        subscribeToConnector(id);
        coreAddress = _coreAddress;
    }
    
    // to be called after aave connector creation
    function subscribeToConnector(uint256 id) override {
        address connector = ICore(coreAddress).connectorId(id);
        IConnector(connector).enterSubscriptionWhitelist();
    }
}