// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import { Ownable } from "@openzeppelin-contracts-5.0.2/access/Ownable.sol";
import { ERC20 } from "@openzeppelin-contracts-5.0.2/token/erc20/ERC20.sol";
import { ERC20Burnable } from "@openzeppelin-contracts-5.0.2/token/erc20/extensions/ERC20Burnable.sol";

contract Test20 is Ownable, ERC20("Test ERC20", "T20"), ERC20Burnable {
	constructor(address owner) Ownable(owner) {}

	function mint(address to, uint256 value) external onlyOwner {
		_mint(to, value);
	}
}
