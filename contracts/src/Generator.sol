// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {UD60x18, wrap} from "@prb/math/UD60x18.sol";

contract Generator {
    function ln(uint256 xWad) public pure returns (uint256) {
        UD60x18 ONE = wrap(1e18);
        UD60x18 TWO = wrap(2e18);

        UD60x18 x = wrap(xWad);
        UD60x18 res = x.pow(ONE.add(ONE)).add(ONE).ln();
        return res.unwrap();
    }

    function rootOfQuadraticEquation(
        uint256 xWad
    ) public pure returns (uint256) {
        UD60x18 ONE = wrap(1e18);
        UD60x18 TWO = wrap(2e18);

        UD60x18 x = wrap(xWad);

        UD60x18 a = wrap(1.343e18);
        UD60x18 b = wrap(432432.244e18);
        UD60x18 c = wrap(4343.122e18);
        UD60x18 y = a.mul(x.pow(TWO)).add(b.mul(x)).add(c);
        return y.unwrap();
    }

    function generateScore(uint256 xWad) public pure returns (uint256) {
        return ln(rootOfQuadraticEquation(xWad));
    }
}
