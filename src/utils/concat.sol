// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

function concat(bytes[] memory left, bytes[] memory right) pure returns (bytes[] memory) {
    bytes[] memory combined = new bytes[](left.length + right.length);
    for (uint256 i = 0; i < left.length; i++) {
        combined[i] = left[i];
    }
    for (uint256 i = 0; i < right.length; i++) {
        combined[left.length + i] = right[i];
    }
    return combined;
}
