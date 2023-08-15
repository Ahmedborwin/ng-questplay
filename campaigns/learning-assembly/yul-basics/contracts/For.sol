// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract For {
    /// @notice Sum the elements in [`beg`, `end`) and return the result.
    /// Skips elements divisible by 5.
    /// Exits the summation loop when it encounters a factor of `end`.
    /// @dev You can ignore overflow / underflow bugs.
    function sumElements(
        uint256 beg,
        uint256 end
    ) public pure returns (uint256 sum) {
        assembly {
            sum := 0
            for {
                let i := beg
            } lt(i, end) {

            } {
                // Check if i is divisible by 5; if true, skip iteration
                if iszero(mod(i, 5)) {
                    // Increment i by 1
                    i := add(i, 1)
                    continue
                }
                // Check if i is a factor of end; if true, exit the loop
                if iszero(mod(end, i)) {
                    break
                }
                // Add the current value of i to the sum
                sum := add(sum, i)
                // Increment i by 1
                i := add(i, 1)
            }
        }
        return sum;
    }
}
