// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SafeMath {
    /// @notice Returns lhs + rhs.
    /// @dev Reverts on overflow / underflow.
    function add(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := add(lhs, rhs)

            // Check for overflow or underflow
            if lt(result, lhs) {
                revert(0, 0)
            }
            //how to check if rhs is equal to largest number

            // if eq(rhs, sub(1, 0)) {
            //     revert(0, 0)
            // }
        }

        return result;
    }

    /// @notice Returns lhs - rhs.
    /// @dev Reverts on overflow / underflow.
    function sub(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly

        assembly {
            result := sub(lhs, rhs)

            if gt(result, sub(0, 1)) {
                revert(0, 0)
            }

            if gt(result, lhs) {
                revert(0, 0)
            }
        }
    }

    /// @notice Returns lhs * rhs.
    /// @dev Reverts on overflow / underflow.
    function mul(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := mul(lhs, rhs)

            if eq(result, add(0, 1)) {
                revert(0, 0)
            }

            if eq(result, sub(0, 1)) {
                revert(0, 0)
            }
        }
    }

    /// @notice Returns lhs / rhs.
    /// @dev Reverts on overflow / underflow.
    function div(int256 lhs, int256 rhs) public pure returns (int256 result) {
        // Convert this to assembly
        assembly {
            result := div(lhs, rhs)

            if or(eq(rhs, 0), lt(rhs, 0)) {
                revert(0, 0)
            }

            if gt(result, lhs) {
                revert(0, 0)
            }
            if eq(result, sub(0, 1)) {
                revert(0, 0)
            }
        }
    }
}
