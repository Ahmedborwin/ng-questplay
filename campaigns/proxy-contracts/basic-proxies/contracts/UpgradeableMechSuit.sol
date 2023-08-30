// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract UpgradeableMechSuit {
    // address public implementation;
    // address internal owner;
    // new notes

    bytes32 internal constant _IMPLEMENTATION_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    bytes32 internal constant _ADMIN_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.admin")) - 1);

    function _getAddress(bytes32 slot) public view returns (address addr) {
        assembly {
            addr := sload(slot)
        }
        return addr;
    }

    function _setAddress(bytes32 slot, address addr) public {
        assembly {
            sstore(slot, addr)
        }
    }

    /// @notice Constructs the contract
    /// @param _implementation Address of logic contract to be linked
    constructor(address _implementation) {
        _setAddress(_ADMIN_SLOT, msg.sender);
        _setAddress(_IMPLEMENTATION_SLOT, _implementation);
    }

    /// @notice Upgrades contract by updating the linked logic contract
    /// @param _implementation Address of new logic contract to be linked
    function upgradeTo(address _implementation) external {
        address owner = _getAddress(_ADMIN_SLOT);
        require(msg.sender == owner);
        _setAddress(_IMPLEMENTATION_SLOT, _implementation);
    }

    receive() external payable {}

    fallback() external payable {
        address _impl = _getAddress(_IMPLEMENTATION_SLOT);
        assembly {
            let ptr := mload(0x40)

            // (1) copy incoming calldata into memory
            calldatacopy(ptr, 0, calldatasize())

            // (2) forward call to implementation contract
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()

            // (3) retrieve return data
            returndatacopy(ptr, 0, size)

            // (4) forward return data back to caller
            switch result
            case 0 {
                revert(ptr, size)
            } // Revert if call failed
            default {
                return(ptr, size)
            } // Return if call succeeded
        }
    }
}
