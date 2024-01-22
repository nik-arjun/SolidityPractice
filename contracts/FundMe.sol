// Get Funds from User
// Withdraw Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "./PriceConverter.sol";

// 756935 gas
// 737202 gas (After adding constant keyword)

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 2571 gas
    // 347 gas (After adding constant keyword)
    address public i_owner;
    // 2549 gas
    // 439 gas (After adding immutable keyword)
    address[] public funders;
    mapping (address => uint256) public addressToAmount;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract ?

        require(msg.value.getConversionRate() >= MINIMUM_USD,"Don't have enough Balance,");
        //require(getConversionRate(msg.value) >= MINIMUM_USD,"Don't have enough Balance,");
        // 18 decimal places

        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex<funders.length; funderIndex++) {
            address funder = funders[funderIndex];

            addressToAmount[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // actually withdraw the fund

        /* Methods to transfer money */
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Call Failed");


        // The Above 2 is capped at 2300 gas and above that will throw error
        
        
        // call
        (bool callSuccess, /* bool memory dataReturned */) = i_owner.call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not the Owner");
        if(msg.sender != i_owner)
            revert NotOwner();
        _; // Tells the function to execute the remaining Code.
    }

    /* modifier onlyOwner {
        _; // Tells the function to execute the remaining Code first.
        require(msg.sender == owner, "Sender is not the Owner");
    }*/


    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
    
}

// $1885.995833960000000000