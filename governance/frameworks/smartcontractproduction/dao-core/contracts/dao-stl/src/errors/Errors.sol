/*
    Contract: Errors

    A contract that keeps a number of error codes (uint16). Will probably be moved out of the contract
    when Solidity supports that.

    Categories offset by 1000; each with a generic message at the start. Sub-categories offset by 100.

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
contract Errors {

    // Constant: NO_ERROR
    // Used to report that the function was executed normally.
    uint16 constant NO_ERROR = 0;
    // Constant: ERROR
    // Unspecified error.
    uint16 constant ERROR = 1;

    // ********************** Resources **********************

    // Constant: RESOURCE_ERROR
    // Unspecified resource error.
    uint16 constant RESOURCE_ERROR = 1000;
    // Constant: RESOURCE_NOT_FOUND
    // A target resource was not found.
    uint16 constant RESOURCE_NOT_FOUND = 1001;
    // Constant: RESOURCE_ALREADY_EXISTS
    // A resource could not be added because it already exists.
    uint16 constant RESOURCE_ALREADY_EXISTS = 1002;

    // ********************** Access **********************

    // Constant: ACCESS_DENIED
    // Caller lacks the proper permissionse.
    uint16 constant ACCESS_DENIED = 2000;

    // ********************** Input **********************

    // Constant: PARAMETER_ERROR
    // Unspecified error with input parameter.
    uint16 constant PARAMETER_ERROR = 3000;
    // Constant: INVALID_PARAM_VALUE
    // Input parameter is invalid.
    uint16 constant INVALID_PARAM_VALUE = 3001;
    // Constant: NULL_PARAM_NOT_ALLOWED
    // An input parameter is a null value, which is not allowed.
    uint16 constant NULL_PARAM_NOT_ALLOWED = 3002;
    // Constant: INTEGER_OUT_OF_BOUNDS
    // An integer parameter is outside of some given boundary.
    uint16 constant INTEGER_OUT_OF_BOUNDS = 3003;

    // --- Arrays ---

    // Constant: ARRAY_INDEX_OUT_OF_BOUNDS
    // An array was accessed with an illegal index.
    uint16 constant ARRAY_INDEX_OUT_OF_BOUNDS = 3100;

    // ********************** Contract states *******************

    // Constant: INVALID_STATE
    // Catch-all for when the state of the contract does not allow an operation in its current state.
    uint16 constant INVALID_STATE = 4000;

    // ********************** Transfers *******************

    // Constant: TRANSFER_FAILED
    // A transfer failed for unspecified reasons.
    uint16 constant TRANSFER_FAILED = 8000;
    // Constant: NO_SENDER_ACCOUNT
    // A transfer failed because the sender account did not exist.
    uint16 constant NO_SENDER_ACCOUNT = 8001;
    // Constant: NO_TARGET_ACCOUNT
    // A transfer failed because the target account did not exist.
    uint16 constant NO_TARGET_ACCOUNT = 8002;
    // Constant: TARGET_IS_SENDER
    // A transfer failed because the sender and the receiver is the same account.
    uint16 constant TARGET_IS_SENDER = 8003;
    // Constant: TRANSFER_NOT_ALLOWED
    // A transfer failed because it was not allowed.
    uint16 constant TRANSFER_NOT_ALLOWED = 8004;

    // --- Balance related ---

    // Constant: INSUFFICIENT_SENDER_BALANCE
    // A transfer failed because the sender did not have a high enough balance.
    uint16 constant INSUFFICIENT_SENDER_BALANCE = 8100;
    // Constant: TRANSFERRED_AMOUNT_TOO_HIGH
    // A transfer failed because the transferred amount was higher then allowed.
    uint16 constant TRANSFERRED_AMOUNT_TOO_HIGH = 8101;

}