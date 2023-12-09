// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

abstract contract ConnectorBuilder {
    function createConnector() public virtual {
        // have a basic implementation
    }

    function registerConnector(address coreAddress) virtual public {
        // default implementation to call 
    }
}

abstract contract ConnectorSubscriber {
 function subscribeToConnector(uint256 connectorId) virtual public {}
}