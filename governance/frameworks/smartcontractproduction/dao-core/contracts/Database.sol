/*
    File: Database.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
import "Doug";

/*
    Contract: Database

    Interface for databases.
*/
contract Database is DougEnabled {

    /*
        Event: SetActionsName

        Params:
            actionsName (bytes32) - The name.
            error (uint16) - An error code.
    */
    event SetActionsName(bytes32 indexed actionsName, uint16 indexed error);


    /*
        Function: actionsName

        Get the name of the actions-contract that has write privileges.

        Returns:
            actionsName (bytes32) - The name.
    */
    function actionsName() constant returns (bytes32 actionsName);

    /*
        Function: setActionsName

        Set the name of the actions-contract that has write privileges. Can only
        be done by the contract with current write privileges.

        Params:
            actionsName (bytes32) - The name.

        Returns:
            error (uint16) - An error code.
    */
    function setActionsName(bytes32 actionsName) returns (uint16 error);

    /*
        Function: _checkCaller

        Method that implementations should use to check if an address is a valid caller.

        Returns:
            (bool) - True means the address was set successfully.
    */
    function _checkCaller() constant internal returns (bool);

}

/*
    Contract: DefaultDatabase

    Base contract for databases. Provides an internal method for checking if caller is an actions contract.

*/
contract DefaultDatabase is Database, DefaultDougEnabled {

    bytes32 _actionsName;

    /*
        Function: setActionsName

        Set the name of the actions-contract that has write privileges. Can only
        be done by the contract with current write privileges.

        Params:
            actionsName (bytes32) - The name.

        Returns:
            error (uint16) - An error code.
    */
    function DefaultDatabase(bytes32 actionsName) {
        _actionsName = actionsName;
    }

    /*
        Function: _checkCaller

        Check if the caller is registered as an actions contract in doug.

        Returns:
            (bool) - True means the address was set successfully.
    */
    function _checkCaller() constant internal returns (bool) {
        return _DOUG.actionsContractId(msg.sender) == _actionsName;
    }

    /*
        Function: actionsName

        Get the name of the actions-contract that has write privileges.

        Returns:
            actionsName (bytes32) - The name.
    */
    function actionsName() constant returns (bytes32 actionsName) {
        return _actionsName;
    }

    /*
        Function: setActionsName

        Set the name of the actions-contract that has write privileges. Can only
        be done by the contract with current write privileges.

        Params:
            actionsName (bytes32) - The name.

        Returns:
            error (uint16) - An error code.
    */
    function setActionsName(bytes32 actionsName) returns (uint16 error) {
        if (_DOUG.actionsContractId(msg.sender) != _actionsName)
            error = ACCESS_DENIED;
        else
            _actionsName = actionsName;
        SetActionsName(actionsName, error);
    }

}
