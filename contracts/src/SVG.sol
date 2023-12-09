// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {User, Score} from "./Core.sol";

library SVG {
    function generateSVG(
        address userAddress,
        uint256 nativeSecurity,
        uint256 aggregateScore,
        Score[] memory scores
    ) public pure returns (string memory result) {
        result = string.concat(
            '<svg width="290" height="500" viewBox="0 0 290 500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><defs><filter id="f1"><feImage result="p2" xlink:href="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nMjkwJyBoZWlnaHQ9JzUwMCcgdmlld0JveD0nMCAwIDI5MCA1MDAnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Zyc+PGNpcmNsZSBjeD0nMTYnIGN5PScyMzInIHI9JzEyMHB4JyBmaWxsPScjZDgyMTA5Jy8+PC9zdmc+"/><feImage result="p3" xlink:href="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nMjkwJyBoZWlnaHQ9JzUwMCcgdmlld0JveD0nMCAwIDI5MCA1MDAnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Zyc+PGNpcmNsZSBjeD0nMjAnIGN5PScxMDAnIHI9JzEzMHB4JyBmaWxsPScjZGExZGRkJy8+PC9zdmc+"/><feBlend mode="exclusion" in2="p2"/><feBlend mode="overlay" in2="p3" result="blendOut"/><feGaussianBlur in="blendOut" stdDeviation="42"/></filter><clipPath id="corners"><rect width="290" height="500" rx="42" ry="42"/></clipPath><filter id="top-region-blur"><feGaussianBlur in="SourceGraphic" stdDeviation="24"/></filter><linearGradient id="grad-symbol"><stop offset="0.7" stop-color="white" stop-opacity="1"/><stop offset=".95" stop-color="white" stop-opacity="0"/></linearGradient><mask id="fade-symbol" maskContentUnits="userSpaceOnUse"><rect width="290px" height="200px" fill="url(#grad-symbol)"/></mask></defs><g clip-path="url(#corners)"><rect fill="2c9715" x="0px" y="0px" width="290px" height="500px"/><rect style="filter:url(#f1)" x="0px" y="0px" width="290px" height="500px"/><g style="filter:url(#top-region-blur);transform:scale(1.5);transform-origin:center top"><rect fill="none" x="0px" y="0px" width="290px" height="500px"/><ellipse cx="50%" cy="0px" rx="180px" ry="120px" fill="#000" opacity="0.85"/></g><rect x="0" y="0" width="290" height="500" rx="42" ry="42" fill="rgba(0,0,0,0)" stroke="rgba(255,255,255,0.2)"/></g><g mask="url(#fade-symbol)"><text y="70px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="26px">DeFi Credance</text><text y="110px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="14px">User: ',
            Strings.toHexString(uint160(userAddress)),
            '</text><text y="140px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="14px">AggregateScore:',
            Strings.toString(aggregateScore),
            '</text><text y="170px" x="32px" fill="white" font-family="\'Courier New\', monospace" font-weight="200" font-size="14px">Native Securiy: ',
            Strings.toString(nativeSecurity),
            "</text></g></svg>"
        );
    }
}
