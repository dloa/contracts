/*
    File: Executor.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)

    Contract: Executor

    A contract that executes code and stores the error-code.
*/
contract Executor {

    /*
        Function: execError

        Get the error code returned by the function that was executed as a response to a successful vote.

        Returns:
            execError (uint16) - The error code.
    */
    function execError() constant returns (uint16 execError);

    /*
        Function: _execute

        Internal function that should be called upon a successful vote.

        Returns:
            error (uint16) - An error code.
    */
    function _execute() internal returns (uint16 error);

}