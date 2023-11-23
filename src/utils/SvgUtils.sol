// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

library SvgUtils {
    function svgToImageURI(
        string memory _svg
    ) public pure returns (string memory) {
        //? example: <svg>...</svg>
        //4 returns -> data:image/svg+xml;base64,...
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(abi.encodePacked(_svg));
        // return string(abi.encodePacked(baseURI, svgBase64Encoded));
        return string.concat(baseURI, svgBase64Encoded);
    }
}
