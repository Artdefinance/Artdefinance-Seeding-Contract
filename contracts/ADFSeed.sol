// Sources flattened with hardhat v2.12.6 https://hardhat.org

// File @openzeppelin/contracts/utils/Context.sol@v4.8.1

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/access/Ownable.sol@v4.8.1

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


// File @openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol@v4.8.1


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/draft-IERC20Permit.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}


// File @openzeppelin/contracts/utils/Address.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
     * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
     *
     * _Available since v4.8._
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason or using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}


// File @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;



/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    function safePermit(
        IERC20Permit token,
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal {
        uint256 nonceBefore = token.nonces(owner);
        token.permit(owner, spender, value, deadline, v, r, s);
        uint256 nonceAfter = token.nonces(owner);
        require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File @openzeppelin/contracts/security/ReentrancyGuard.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.8.0) (security/ReentrancyGuard.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}


// File @openzeppelin/contracts/utils/math/Math.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.8.0) (utils/math/Math.sol)

pragma solidity ^0.8.0;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    enum Rounding {
        Down, // Toward negative infinity
        Up, // Toward infinity
        Zero // Toward zero
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds up instead
     * of rounding down.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or denominator == 0
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv)
     * with further edits by Uniswap Labs also under MIT license.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            require(denominator > prod1);

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator. Always >= 1.
            // See https://cs.stackexchange.com/q/138556/92363.

            // Does not overflow because the denominator cannot be zero at this stage in the function.
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also works
            // in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding
    ) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // → `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // → `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (rounding == Rounding.Up && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (rounding == Rounding.Up && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10**64) {
                value /= 10**64;
                result += 64;
            }
            if (value >= 10**32) {
                value /= 10**32;
                result += 32;
            }
            if (value >= 10**16) {
                value /= 10**16;
                result += 16;
            }
            if (value >= 10**8) {
                value /= 10**8;
                result += 8;
            }
            if (value >= 10**4) {
                value /= 10**4;
                result += 4;
            }
            if (value >= 10**2) {
                value /= 10**2;
                result += 2;
            }
            if (value >= 10**1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (rounding == Rounding.Up && 10**result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256, rounded down, of a positive value.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (rounding == Rounding.Up && 1 << (result * 8) < value ? 1 : 0);
        }
    }
}


// File @openzeppelin/contracts/utils/math/SafeMath.sol@v4.8.1


// OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *  
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}


// File contracts/defi/seed.sol


pragma solidity >=0.4.22 <0.9.0;






/// @title AdfSeeding
/// @notice setArtist -> ( startRound -> seeding and unseeding -> endRound (1 week) )
/// @dev  Seeding takes a certain amount of token to the artist and receives a Reward.
///       Artists are also paid a reward at a fixed reward rate 
contract ADFSeed is Ownable , ReentrancyGuard{

    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public immutable token;
    address public immutable reserveAddress;

    uint256 private seederClaimTime = 12 weeks;
    uint256 private artistClaimTime = 26 weeks;

    uint256 private weightDiv = 100;
    uint256 private artistRewardRound = 1;
    uint256 private requestPeriod = 3;
    uint256 private reserveStartRound = 4;

    enum claimStatus { non , claim , imClaim }
    enum seedStatus { non , seeding , unseeding }

// Structures store information about rounds, seeders, artists and rewards.
    struct roundInfo {
        bool _roundStatus; 
        uint256 _tierCount;
        uint256 _roundStartTime;
        uint256 _roundEndTime;
        uint256 _totalSeeding;
        uint256 _roundReward;
        uint256 _claimReward;
    }

    struct artistInfo {
        address _artist;
        uint256 _seedingAmount;
        uint256 _commission;
        bool _jailed;
    }

    struct seederInfo {
        address _seeder;
        uint256 _amount;
        uint256 _seedingRound;
        uint256 _seedingTime;
        seedStatus _seedStatus;
    }

    struct artistRewardInfo {
        uint256 _rewardAmount;
        uint256 _rewardTime;
        bool _withdrawn;
    }
    
    struct seederRewardInfo {
        uint256 _round;
        uint256 _amount;
        uint256 _requestTime;
        claimStatus _claimStatus;
    }

    struct seederActionInfo {
        uint256 _round;
        uint256 _amount;
        uint256 _actionTime;
    }


    uint256 public currentRound;

    /// Amount minus the claim made from the round reward.
    uint256 private reserveAmount;

    /// Total artist list and mapping of addresses to their indices.
    artistInfo[] private artistList;
    mapping (address => uint256) private artistListIndex;

    /// Artist ranking by round
    mapping ( uint256 => artistInfo[]) private orderAddressByRound;

    /// seeder info for each artist
    mapping ( address => seederInfo[] ) private artistSeeder; 
    mapping ( address => mapping (address => uint256)) private artistSeederIndex; 
    
    /// Information about each round.
    mapping ( uint256 => roundInfo ) private RoundInfo;

    /// seeder to artist seeding or unseeding info.
    mapping ( address => mapping (address => seederActionInfo[])) private seederToArtistTxInfo;

    /// artist reward information by each round.
    mapping ( uint256 => mapping ( address => artistRewardInfo )) private artistReward;

    /// artist reward claim round.
    mapping ( address => uint256) private artistRewardClaimRound;
    /// rewarding all seeders after excluding the artist's commission for each round.
    mapping ( uint256 => mapping ( address => uint256 ) ) private seedersReward; 
    
    /// reward info for each seeder.
    mapping ( address => seederRewardInfo[] ) private sReward;
    mapping ( address => uint256) private sRewardFrom;

    mapping ( uint256 => mapping (address => uint256)) private seederReqTimes;
    mapping ( uint256 => mapping (address => bool) ) private isSeederReq;

    mapping ( address => uint256) public seederClaimAmount;
    mapping ( address => uint256) public seederTotalReward;

    bool private seedingPause;

    /**
     * event
    */
    event seedingEvent (address artist, address seeder, uint256 amount , uint256 seedingTime );
    event unseedEvent (address artist , address seeder , uint256 amount , uint256 unseedTime);

    event startRoundEvent (uint256 round , uint256 roundStartTime , uint256 roundEndTime);
    event endRoundEvent (uint256 round , uint256 roundEndTime , address[] artistList , uint256[] artistReward);

    event artistRewardDistEvent ( address[] artist , uint256[] amount , uint256 round , uint256 disTime);
    event artistRewardClaimEvent ( address artist , uint256 amount , uint256 claimTime);

    event seederRewardReqEvent (uint256 round , address seeder , uint256 reqTime , uint256 claimTime);
    event seederClaimEvent (address seeder , uint256 amount , uint256 claimTime);
    event seederRewardInfoEvent (address[] artists , uint256[] rewards , address seeder , uint256 round) ;
    event seederImClaimEvent (address seeder , uint256 amount , uint256 claimTime);

    /**
     *  Add Event
     */
    event pauseEvent ( address owner , bool enbled , uint256 setPauseTime );
    event artistJailEvent ( address[] jailArtists , uint256 jailTime);
    event artistUnJailEvent (address[] unJailArtists , uint256 unJailTime);

    event setArtistEvent ( address[] artists , uint256[] commissions);
    event updateArtistEvent (address[] artists , uint256[] commissions);

    constructor (IERC20 _token , address _reserve) {
        token = _token;
        reserveAddress = _reserve;
        seedingPause = false;
    }

    modifier isPause () {
        require (!seedingPause , "");
        _;
    }
    
    function setPause ( bool _enabled ) external onlyOwner {
        seedingPause = _enabled;

        emit pauseEvent(msg.sender, _enabled, block.timestamp);
    }
    /// @notice setArtist is called once before the start of round one.
    /// @param _artistAddress artistlist.
    /// @param _commissions Artist commissions ranging from 0% to 5 %.
    function setArtist ( address[] memory _artistAddress , uint256[] memory _commissions , uint256 _arrayCount ) public onlyOwner {
        
        require (_artistAddress.length == _arrayCount &&
                 _commissions.length == _arrayCount , "array size fail");

        for (uint256 i =0 ; i < _arrayCount; i++ ) {
            
            if (artistList.length != 0) {
                require (artistList[artistListIndex[_artistAddress[i]]]._artist != _artistAddress[i] , "aleady exist artist");
                require (_commissions[i] <= 5 , "commission cannot exceed five percentage");
            }

            artistInfo memory artist_info = artistInfo ({
                _artist         : _artistAddress[i],
                _seedingAmount  : 0,
                _commission     : _commissions[i],
                _jailed         : false 
            });

            artistListIndex[_artistAddress[i]] = artistList.length;
            artistList.push(artist_info);    
        }

        emit setArtistEvent(_artistAddress , _commissions); 
    }
    
    /// @notice update artist commissions.
    function updateArtist ( address[] memory _artistAddress , uint256[] memory _commissions , uint _arrayCount) public onlyOwner {
        
        require (_artistAddress.length == _arrayCount &&
                 _commissions.length == _arrayCount , "array size fail");
        
        for ( uint i = 0; i < _arrayCount ; i++) {
            
            require (artistList[artistListIndex[_artistAddress[i]]]._artist == _artistAddress[i] , "non-exist artist");
            require (_commissions[i] <= 5 , "commission cannot exceed five percentage");

            artistInfo storage aList = artistList[artistListIndex[_artistAddress[i]]];
            aList._commission = _commissions[i];
        }

        emit updateArtistEvent(_artistAddress, _commissions);
    }

    /// @notice Jail the registered artist and retrieve their remaining rewards.
    function jailArtist ( address[] memory _artistAddress ) public onlyOwner {

        for ( uint i = 0 ; i < _artistAddress.length; i++) {
            _getRemainingReward(_artistAddress[i]);
            artistList[artistListIndex[_artistAddress[i]]]._jailed = true;
        }

        emit artistJailEvent( _artistAddress , block.timestamp );
    }

    function _getRemainingReward ( address _artist ) internal {

        uint256 from = artistRewardClaimRound[_artist];
        uint256 to = currentRound - artistRewardRound;
        uint256 totalReqReward;
        uint256 i;
        for ( i = from ; i <= to ; i++ ) {
            totalReqReward = totalReqReward.add(artistReward[i][_artist]._rewardAmount);
            artistReward[i][_artist]._withdrawn = true;
        }

        reserveAmount = reserveAmount.sub(totalReqReward);
    }


    function unjailArtist (address[] memory _artistAddress) public onlyOwner {

        for ( uint i = 0 ; i < _artistAddress.length; i++) {

            artistList[artistListIndex[_artistAddress[i]]]._jailed = false;
        }

        emit artistUnJailEvent(_artistAddress , block.timestamp);
    }
    
    function getArtistCount () public view returns ( uint256 _count ) {
        _count = artistList.length;
    }

    function getAllArtists () public view returns ( artistInfo[] memory) {
        return artistList;
    }

    function getRoundArtistOrder ( uint256 _round ) public view returns ( artistInfo[] memory ) {
        return orderAddressByRound[_round];
    }

    
    /// @notice Start the round on a weekly basis.
    /// @param _tierCnt Tier count based on the number of artists.
    function startRound ( uint256 _tierCnt  ) public onlyOwner {
        
        require (RoundInfo[currentRound]._roundStatus == false , "Unable to start round");

        currentRound++;

        roundInfo storage round_info = RoundInfo[currentRound];

        round_info._tierCount = _tierCnt;
        round_info._totalSeeding = RoundInfo[currentRound-1]._totalSeeding;
        round_info._roundStartTime = block.timestamp;
        round_info._roundEndTime = block.timestamp + 1 weeks;
        round_info._roundStatus = true;

        uint256 reserveTransferAmount;

        if (currentRound >= reserveStartRound ) {

            reserveTransferAmount = getReserveAmount(currentRound - requestPeriod);

            token.safeTransfer(reserveAddress , reserveTransferAmount);

            reserveAmount = 0;
        }

        emit startRoundEvent(currentRound , round_info._roundStartTime , round_info._roundEndTime);

    }
    /* Immediate claim confirmation */
    function getReserveAmount ( uint256 _round ) public view returns ( uint256 ) {
        
        uint256 roundReserveAmount = (reserveAmount.add(RoundInfo[_round]._roundReward)).sub(RoundInfo[_round]._claimReward);

        return roundReserveAmount;
    }  


    function getRoundInfo (uint256 round) public view returns ( roundInfo memory ) {

        return RoundInfo[round];
    }

    function getRoundTotalAmount( uint256 _round ) public view returns (uint256) {
        
        return RoundInfo[_round]._totalSeeding;
    }


    ///@notice Call startRound a week after the call
    ///        Rewards are distributed to artists
    ///        Seeder rewards are distributed separately upon request
    ///@param _roundRewardAmount Total reward between the rounds.
    function endRound (uint256 _roundRewardAmount) public onlyOwner {
        
        require ( RoundInfo[currentRound]._roundStatus == true , "Unable to end round");
        require ( RoundInfo[currentRound]._roundEndTime <= block.timestamp , "endRound should be a week after the start");

        roundInfo storage round_info = RoundInfo[currentRound];

        round_info._roundStatus = false;
        round_info._roundReward = _roundRewardAmount;


        artistInfo[] memory tmp = _sortArtist();
        
        for (uint256 i = 0 ; i < tmp.length ; i++) {

            orderAddressByRound[currentRound].push(tmp[i]);
        }
        
        ( address[] memory _artists , uint256[] memory _rewards ) = _artistRewardDist( orderAddressByRound[currentRound] , orderAddressByRound[currentRound].length );


        token.safeTransferFrom(msg.sender , address(this) , _roundRewardAmount);

        emit endRoundEvent( currentRound , round_info._roundEndTime , _artists , _rewards );
    }

    function _artistRewardDist (artistInfo[] memory _info , uint256 _infoLength) 
        internal 
        returns (address[] memory , uint256[] memory) 
    {

        roundInfo storage round_info = RoundInfo[currentRound];
    
        uint256 amountByTier = round_info._roundReward / round_info._tierCount; // tier 당 reward
        
        address[] memory _list = new address[](_infoLength);
        uint256[] memory _rewardList = new uint256[](_infoLength);

        for (uint256 i = 0 ; i < _infoLength ; i++) {

            ( , uint256 members) = _getTier(i + 1);
            
            uint256 amountByMember = amountByTier.div(members);

            uint256 artistRoundReward;

            if (_info[i]._seedingAmount == 0 || _info[i]._jailed == true) {
                artistRoundReward = 0;
            }else {
                artistRoundReward = ( amountByMember * _info[i]._commission) / 100;
            }
            
            _list[i] = _info[i]._artist;
            _rewardList[i] = artistRoundReward;
            
            round_info._claimReward = round_info._claimReward.add(artistRoundReward);

            if (_info[i]._jailed == false) {
                seedersReward[currentRound][_info[i]._artist] = amountByMember.sub(artistRoundReward);
                _artistRewardDist ( _info[i]._artist , artistRoundReward );
            }else {
                seedersReward[currentRound][_info[i]._artist] = 0;
            }
        }

        return ( _list , _rewardList );
    }

    function _artistRewardDist(  address _artistAddr , uint256 _amount) internal  {
        
        artistRewardInfo memory artistReward_info = artistRewardInfo ({
            _rewardAmount : _amount,
            _rewardTime : block.timestamp + artistClaimTime,
            _withdrawn : false
        });
        
        artistReward[currentRound][_artistAddr] = artistReward_info;
    }
    ///@notice artist reward claim 
    function artistRewardClaim () external nonReentrant {
        
        require (artistList[artistListIndex[msg.sender]]._artist == msg.sender , "msg.sender is not artist");

        if (artistRewardClaimRound[msg.sender] == 0) {
            artistRewardClaimRound[msg.sender] = 1;
        }

        (uint256 totalReqReward , uint256 index) = _getArtistReward(msg.sender);

        require (totalReqReward > 0 , "artist reward is 0");

        artistRewardClaimRound[msg.sender] = index;

        token.safeTransfer(msg.sender , totalReqReward);
        
        emit artistRewardClaimEvent( msg.sender ,totalReqReward, block.timestamp );

    } 

    function _getArtistReward (address _artist) internal returns (uint256 , uint256) {

        uint256 from = artistRewardClaimRound[_artist];
        uint256 to = currentRound - artistRewardRound;
        uint256 totalReqReward;
        uint256 i;

        for ( i = from ; i <= to ; i++ ) {

            if (artistReward[i][_artist]._rewardTime <= block.timestamp &&
                artistReward[i][_artist]._withdrawn == false) 
            {
                totalReqReward = totalReqReward.add(artistReward[i][_artist]._rewardAmount);
                artistReward[i][_artist]._withdrawn = true;
            }
        }
        
        return ( totalReqReward , i );
    }

    function getArtistRewardInfo ( address _artist , uint256 _round ) 
        public 
        view 
        returns ( artistRewardInfo memory ) 
    {
        return artistReward[_round][_artist];
    }

    /// @notice The seeder requests a reward within a fixed period of time
    /// @param _round the requestable round
    /// @param _artists All artists being seeded by seeders 
    function seederRewardReq ( uint256 _round , address[] memory _artists) external nonReentrant isPause{

        require ( _round < currentRound , "request round must be less than currentRound" );
        require ( isReqRound(_round) , "the Request round has passed" );
        require ( isArtistSeeding(_round , msg.sender , _artists) , "msg.sender is not seeding" );
        require ( isSeederReq[_round][msg.sender] == false , "aleady request");
        
    
        isSeederReq[_round][msg.sender] = true;

        seederReqTimes[_round][msg.sender] = block.timestamp + seederClaimTime;
        
        emit seederRewardReqEvent( _round , msg.sender , block.timestamp , seederReqTimes[_round][msg.sender]);

    }
    
    function isArtistSeeding (uint256 _round , address _seeder , address[] memory _artists) 
        internal 
        view 
        returns ( bool ) 
    {     
        for ( uint256 i = 0 ; i < _artists.length ; i++) {
            if ( getRoundSeederArtistAmount(_round , _seeder , _artists[i]) == 0 ) {      
                return false;
            }
        }

        return true;
    }

    function isReqRound ( uint256 _round ) internal view returns (bool) {

        if (currentRound < 3 ) return true; 
        else {
            if ((currentRound - _round) > 2) {return false;}
        }
        return true;
    }

    ///@notice Calculate the reward for the requested seeder
    ///@param _artists All artists seeding by the seeder 
    ///@param _denominators Total value for all seeds that have been seeded to one artist
    ///@param _weights Weight over seeding time 
    ///@param _seeder The seeder who called 'seederRewardReq' function
    ///@param _round The requestable round
    function setSeederRewardInfo ( 
        address[] memory _artists,
        uint256[] memory _denominators,
        uint256[] memory _weights,
        address _seeder,
        uint256 _round,
        uint256 _arrayLength
    ) external  onlyOwner {
        
        require ( _artists.length == _arrayLength &&
                  _denominators.length == _arrayLength &&
                  _weights.length == _arrayLength , "array size fail");

        roundInfo storage round_info = RoundInfo[_round];

        uint256 roundTotalReward;
        
        uint256[] memory rewards = new uint256[](_arrayLength);

        for (uint256 i = 0 ; i < _arrayLength; i++) {
            
            require (_weights[i] > 0 , "weight must be greater than zero");
            require (_denominators[i] > 0 , "denominator must be greater than zero");

            uint256 reward = _seederReward (_round , _seeder , _artists[i] , _weights[i] , _denominators[i]);

            roundTotalReward = roundTotalReward.add(reward);

            rewards[i] = reward;
        }

        seederRewardInfo memory seeder_reward = seederRewardInfo ({
            _round : _round,
            _amount : roundTotalReward,
            _requestTime : seederReqTimes[_round][_seeder],
            _claimStatus : claimStatus.non
        });

        sReward[_seeder].push(seeder_reward);

        seederTotalReward[_seeder] = seederTotalReward[_seeder].add(roundTotalReward);

        round_info._claimReward = round_info._claimReward.add( roundTotalReward );

        emit seederRewardInfoEvent(_artists , rewards , _seeder , _round);        
    }
    
    function _seederReward ( uint256 _round , address _seeder , address _artist , uint256 _weight , uint256 _denominator) 
        internal 
        view 
        returns ( uint256 seederReward)
    {
        
        uint256 totalSeedersReward = seedersReward[_round][_artist];
        
        uint256 seederSeedingAmount = getRoundSeederArtistAmount(_round, _seeder, _artist);
        
        if (seederSeedingAmount == 0 || totalSeedersReward == 0) return 0;

    //    seederReward =   (( ( _weight  * seederSeedingAmount ) * totalSeedersReward ) / _denominator) / weightDiv;
        
        seederReward = (( ( _weight.mul(seederSeedingAmount)).mul(totalSeedersReward) ).div(_denominator) ).div(weightDiv);

    }

    function getRoundSeedersReward( uint256 _round , address _artist ) external view returns (uint256) {
        return seedersReward[_round][_artist];
    }

    function getRoundSeederArtistAmount (uint256 _round , address _seeder , address _artist ) 
        public 
        view 
        returns (uint256 seederAmount)
    {
        
        seederActionInfo[] memory actionInfo = seederToArtistTxInfo[_seeder][_artist];
        
        if (actionInfo.length == 0 ) return 0;

        uint256 _from = actionInfo.length-1;

        for ( uint256 i =  _from; i >= 0 ; i-- ) {
            
            if (actionInfo[i]._round <= _round ) {
                seederAmount = actionInfo[i]._amount;
                break;
            }
        }
    }
    /// @notice Reward claim according to the fixed time
    function seederClaim () external nonReentrant isPause{

        require (sReward[msg.sender].length > 0 , 'have no Reward for');

        (uint256 claimReward , uint256 lastIndex) = calClaimReward (msg.sender);
        uint256 calTime = block.timestamp;
        
        require ( claimReward != 0 || seederClaimAmount[msg.sender] != 0 , 'claim reward is 0');

        claimReward = claimReward.add(seederClaimAmount[msg.sender]);

        seederClaimAmount[msg.sender] = 0;

        sRewardFrom[msg.sender] = lastIndex;

        token.safeTransfer( msg.sender, claimReward );

        emit seederClaimEvent( msg.sender, claimReward , calTime);

    }
    
    /// @notice Rewards claim immediately before the fixed time
    function seederImClaim () external nonReentrant isPause {
        require (sReward[msg.sender].length > 0 , 'have no Reward for');
        require (sReward[msg.sender].length > sRewardFrom[msg.sender] , 'ImClaim reward is 0');

        (uint256 claimReward , uint256 imClaimReward ) = calImClaimReward (msg.sender);

        uint256 amount = imClaimReward;

        uint256 calTime = block.timestamp;

        require (amount > 0 , 'ImClaim reward is 0');

        seederClaimAmount[msg.sender] = seederClaimAmount[msg.sender].add(claimReward);

        amount = ( amount.mul(10) ).div(100);

        reserveAmount = imClaimReward.sub(amount);

        token.safeTransfer(msg.sender , amount);        
        
        emit seederImClaimEvent(msg.sender , amount , calTime);

    }

    function calImClaimReward ( address _seeder ) internal returns ( uint256 , uint256 ) {

        seederRewardInfo[] storage info = sReward[_seeder];

        uint256 claimReward;
        uint256 imClaimReward;

        uint256 lastIndex = sRewardFrom[_seeder];

        for (lastIndex ; lastIndex < info.length ; ++lastIndex) {

            if ( info[lastIndex]._requestTime <= block.timestamp && info[lastIndex]._claimStatus == claimStatus.non){
                claimReward += info[lastIndex]._amount;
                info[lastIndex]._claimStatus = claimStatus.claim;
            } else {
                
                imClaimReward += info[lastIndex]._amount;
                info[lastIndex]._claimStatus = claimStatus.imClaim;
            }
        }

        sRewardFrom[_seeder] = lastIndex;

        return ( claimReward , imClaimReward );
    }

    function getSeederReward( address _seeder ) external view returns ( seederRewardInfo[] memory ){
        return sReward[_seeder];
    }

    ///@notice staking to a specific artist
    function seeding ( address _to , uint256 _seedingAmount ) public 
        nonReentrant 
        isPause
    {
        require ( RoundInfo[currentRound]._roundStatus == true , "round is not start status" );
        require ( artistList[artistListIndex[_to]]._jailed == false , "artist is jailed");

        token.safeTransferFrom( msg.sender , address(this) , _seedingAmount );

        artistInfo storage aList = artistList[artistListIndex[_to]];
        aList._seedingAmount = aList._seedingAmount.add(_seedingAmount);
        
        uint256 seederAmount;

        if ( _checkSeeder(msg.sender , _to) ) {  

            seederInfo memory seeder_info = seederInfo ({
                _seeder         : msg.sender,
                _amount         : _seedingAmount,
                _seedingRound   : currentRound,
                _seedingTime    : block.timestamp,
                _seedStatus     : seedStatus.seeding
               
            });

            artistSeederIndex[_to][msg.sender] = artistSeeder[_to].length;
            artistSeeder[_to].push(seeder_info);
            seederAmount = _seedingAmount;

        } else {
            
            seederInfo storage seeder_info = artistSeeder[_to][artistSeederIndex[_to][msg.sender]];
            seeder_info._amount = seeder_info._amount.add(_seedingAmount);
            seeder_info._seedingTime = block.timestamp;
            seederAmount = seeder_info._amount;
        }
        
        seederActionInfo[] memory tmp = seederToArtistTxInfo[msg.sender][_to];
        
        if ( tmp.length == 0 || tmp[tmp.length-1]._round != currentRound) {
            
            seederActionInfo memory actionInfo = seederActionInfo ({
                _round : currentRound,
                _amount : seederAmount,
                _actionTime : block.timestamp
            });

            seederToArtistTxInfo[msg.sender][_to].push(actionInfo);
        } else {

            seederToArtistTxInfo[msg.sender][_to][seederToArtistTxInfo[msg.sender][_to].length-1]._actionTime = block.timestamp;
            seederToArtistTxInfo[msg.sender][_to][seederToArtistTxInfo[msg.sender][_to].length-1]._amount = seederAmount;
        }

        roundInfo storage currentRoundInfo = RoundInfo[currentRound];
        currentRoundInfo._totalSeeding = currentRoundInfo._totalSeeding.add(_seedingAmount); 
  
        emit seedingEvent(_to, msg.sender, _seedingAmount, block.timestamp);

    }

    function getSeederArtistTxInfo (address _seeder , address _artist) 
        public 
        view 
        returns(seederActionInfo[] memory) 
    {
        return seederToArtistTxInfo[_seeder][_artist];
    }

    function unseeding ( address _artist ) public nonReentrant {
        
        require ( artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seeder == msg.sender , "msg.sender is not artist seeder");
        require ( artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._amount > 0 , "msg.sender is not seeder");
    //    require ( artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seedingRound > currentRound , "");
    //    require ( artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seedingTime + 4 days > block.timestamp , ""); 

        uint256 amount = artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._amount;
        
        artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seedingRound = currentRound;
        artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seedingTime = block.timestamp;
        artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._seedStatus = seedStatus.unseeding;
        artistSeeder[_artist][artistSeederIndex[_artist][msg.sender]]._amount = 0;


        artistInfo storage aList = artistList[artistListIndex[_artist]];
        aList._seedingAmount = aList._seedingAmount.sub(amount);

        roundInfo storage currentRoundInfo = RoundInfo[currentRound];
        currentRoundInfo._totalSeeding = currentRoundInfo._totalSeeding.sub(amount);
        
        if (seederToArtistTxInfo[msg.sender][_artist][seederToArtistTxInfo[msg.sender][_artist].length-1]._round == currentRound) {

            seederToArtistTxInfo[msg.sender][_artist][seederToArtistTxInfo[msg.sender][_artist].length-1]._actionTime = block.timestamp;
            seederToArtistTxInfo[msg.sender][_artist][seederToArtistTxInfo[msg.sender][_artist].length-1]._amount = 0;
        } else {   
            seederActionInfo memory actionInfo = seederActionInfo ({
                _round : currentRound,
                _amount : 0,
                _actionTime : block.timestamp 
            });

            seederToArtistTxInfo[msg.sender][_artist].push(actionInfo);
        }

        token.safeTransfer(msg.sender , amount);

        emit unseedEvent(_artist, msg.sender, amount, block.timestamp);

    }

    function getSeederAmount ( address _artist , address _seeder) public view returns (uint256) {

        return artistSeeder[_artist][artistSeederIndex[_artist][_seeder]]._amount;
    }

    function calClaimReward (address _seeder) internal returns ( uint256 , uint256) {

        seederRewardInfo[] storage info = sReward[_seeder];

        uint256 claimReward;
        uint256 lastIndex = sRewardFrom[_seeder];
        
        for ( lastIndex ; lastIndex < info.length ; lastIndex++ ) {
            if ( info[lastIndex]._requestTime <= block.timestamp && 
                 info[lastIndex]._claimStatus == claimStatus.non) 
            {           
                claimReward += info[lastIndex]._amount;
                info[lastIndex]._claimStatus = claimStatus.claim;
            } else {
                break;
            }
        }
        
        return (claimReward , lastIndex);
    }

    function _checkSeeder ( address _from , address _to) 
        internal 
        view 
        returns (bool check)
    {

        if ( artistSeeder[_to].length == 0) {
            check = true;
        } else {
            seederInfo memory seeder_info = artistSeeder[_to][artistSeederIndex[_to][_from]];

            if (seeder_info._seeder == _from) {
                check = false;
            }else {
                check = true;
            }            
        }
    }

    function getArtistSeeder ( address _artist ) public view returns (  seederInfo[] memory ) {
        return artistSeeder[_artist];
    }

    function getArtistSeederInfo ( address _artist , address _seeder ) 
        public 
        view 
        returns ( seederInfo memory ) 
    {

        seederInfo memory seeder_info = artistSeeder[_artist][artistSeederIndex[_artist][_seeder]];
        if ( seeder_info._seeder != _seeder) {
            return seederInfo(address(0) , 0 , 0 , 0 , seedStatus.non);
        }

        return artistSeeder[_artist][artistSeederIndex[_artist][_seeder]];
    }
    
    function _sortArtist () internal view returns (artistInfo[] memory){

        artistInfo[] memory tmp = artistList;

        _artistSort(tmp , int(0) , int(tmp.length - 1));

        return tmp;
    }
    
    
    function _getTier ( uint256 _index ) internal view returns (uint256 tier , uint256 members) {

        uint256 totalTier = RoundInfo[currentRound]._tierCount;
        
        for (uint i = 1 ; i <= totalTier ; i++) {

            if ( i == 1 && _index <= 3 ) {
                members = 3;
                tier = i; break;
            }
            else {
                uint256 totalMembers = 3**i;
                members = 3**i - 3**(i-1);
                if (_index <= totalMembers) {
                    tier = i; break;
                }
            }
            
        }
    }
    
    function _artistSort ( artistInfo[] memory arr , int left , int right) internal pure { /* ascend */

        int i = left;
        int j = right;
        artistInfo memory temp;

        if ( i == j ) return;

        uint256 pivot = arr [ uint(left + (right - left) / 2 )]._seedingAmount;

        while ( i <= j ) {
            while ( arr[uint(i)]._seedingAmount > pivot) i++;
            while ( pivot > arr[uint(j)]._seedingAmount) j--;

            if ( i <= j ) {

                temp = arr[uint(i)];
                arr[uint(i)] = arr[uint(j)];
                arr[uint(j)] = temp;
                i++;
                j--;
            }
        }

        if ( left < j )
            _artistSort( arr , left , j );
        if ( i < right)
            _artistSort( arr , i , right);

    }

    function _isContract (address addr) internal view returns (bool) {

        uint256 size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }
    
}
