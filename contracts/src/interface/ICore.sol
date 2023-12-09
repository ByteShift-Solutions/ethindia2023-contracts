
pragma solidity ^0.8.3;

interface ICore {
    function subscribeProtocolToConnector(
        address protocolAddress,
        uint256 targetConnectorId
    ) external;
}