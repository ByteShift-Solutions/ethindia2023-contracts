// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {UD60x18, wrap} from "@prb/math/UD60x18.sol";
import {SD59x18, wrap} from "@prb/math/SD59x18.sol";
import {PointOfConcern} from "./interface/IConnector.sol";

library Generator {
    function lnTransform(UD60x18 x) public pure returns (UD60x18) {
        UD60x18 ONE = wrap(uint256(1e18));
        return x.add(ONE).ln();
    }

    function rootOfQuadraticEquation(
        PointOfConcern[] calldata poc
    ) public pure returns (UD60x18) {
        uint256 len = poc.length;
        SD59x18 x = wrap(int256(0));
        for (uint256 i = 0; i < len; i++) {
            x = x.add(
                wrap(int256(poc[i].variable)).mul(wrap(poc[i].weightage))
            );
        }
        return _intoUD60x18(x);
    }

    function generateScore(
        PointOfConcern[] calldata poc
    ) public pure returns (uint256) {
        return lnTransform(rootOfQuadraticEquation(poc)).unwrap();
    }

    /// @notice Casts an SD59x18 number into UD60x18.
    /// @dev Requirements:
    /// - x can be negative, returns 0 in that case
    function _intoUD60x18(SD59x18 x) private pure returns (UD60x18 result) {
        int256 xInt = SD59x18.unwrap(x);
        if (xInt < 0) {
            xInt = 0;
        }
        result = UD60x18.wrap(uint256(xInt));
    }
}
