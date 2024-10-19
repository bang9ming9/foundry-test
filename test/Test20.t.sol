// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import { Test, console, stdError } from "forge-std/Test.sol";
import { Test20, Ownable } from "../src/Test20.sol";

contract Test20Test is Test {
	address public constant owner = address(100);
	address receiver = address(200);
	Test20 public t20;

	function setUp() public {
		t20 = new Test20(owner);
	}

	function testFailMint() public {
		t20.mint(receiver, 1);
	}

	function testMint() public {
		vm.startPrank(owner);
		t20.mint(receiver, 1);
		vm.stopPrank();

		assertEq(t20.balanceOf(receiver), 1);
	}

	function testMint2() public {
		vm.prank(owner);
		t20.mint(receiver, 1);

		vm.prank(receiver);
		vm.expectRevert(
			abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, receiver),
			address(t20)
		);
		t20.mint(receiver, 1);
		assertEq(t20.balanceOf(receiver), 1);
	}

	function testFailBurn() public {
		assertEq(t20.balanceOf(receiver), 0);
		vm.prank(receiver);
		t20.burn(1);
	}

	function testBurn() public {
		assertEq(t20.balanceOf(receiver), 0);
		vm.prank(owner);
		t20.mint(receiver, 1 ether);

		vm.prank(receiver);
		t20.burn(1 ether);
	}

	function testFailBurnFrom() public {
		assertEq(t20.balanceOf(receiver), 0);
		vm.prank(owner);
		t20.mint(receiver, 1 ether);

		t20.burnFrom(receiver, 1 ether);
	}

	function testBurnFrom() public {
		assertEq(t20.balanceOf(receiver), 0);

		vm.prank(receiver);
		t20.approve(owner, 1 ether);

		vm.startPrank(owner);
		t20.mint(receiver, 1 ether);
		t20.burnFrom(receiver, 1 ether);
		vm.stopPrank();
	}
}
