// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../ConnectorConnection.sol";
import "../Connector.sol";
import "../interface/IConnector.sol";
import "../interface/ICore.sol";

contract Compound is ConnectorSubscriber{

    address connetorAddr;

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
        IConnector(connetorAddr).updateCibilScore(msg.sender,PointOfConcern(1,15));
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        test.transfer(msg.sender, amount);
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