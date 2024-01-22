// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FallbackExample {
    uint256 public result;

    receive() external payable {
        result = msg.value;
    }

    fallback() external payable { }
}