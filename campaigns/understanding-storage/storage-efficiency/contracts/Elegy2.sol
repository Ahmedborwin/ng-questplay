// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Elegy2 {
    uint32[] public lines;
    uint public totalSum;

    constructor(uint32[] memory _lines) {
        lines = _lines;
    }

    function play(uint nonce) external {
        totalSum = 0;
        uint32[] memory tempArray = lines;
        for (uint i = 0; i < tempArray.length; i++) {
            totalSum += (i * nonce) * tempArray[i];
        }
    }
}
