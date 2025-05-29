// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract SimpleDEX {
    address public owner;
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public rate; // 1 A = rate B

    constructor(IERC20 _tokenA, IERC20 _tokenB, uint256 _rate) {
        owner = msg.sender;
        tokenA = _tokenA;
        tokenB = _tokenB;
        rate = _rate;
    }

    function swapAtoB(uint256 amountA) external {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "A transfer failed");
        require(tokenB.transfer(msg.sender, amountA * rate), "B transfer failed");
    }

    function setRate(uint256 newRate) external {
        require(msg.sender == owner, "Only owner");
        rate = newRate;
    }
}
