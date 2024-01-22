// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;
// Before 0.8.0 the number is not checked whether it has reached the upper or lower limit.

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        bigNumber = bigNumber + 1;
    }
}