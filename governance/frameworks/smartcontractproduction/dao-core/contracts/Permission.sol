/*
    File: Permission.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)

    Contract: Permission

    Interface for permission contracts with a root user and a number of permission owners.
*/
contract Permission {

    /*
        Event: SetRoot

        Params:
            newRoot (address) - The new root-address.
            error (uint16) - An error code.
    */
    event SetRoot(address indexed newRoot, uint16 indexed error);

    /*
        Event: AddOwner

        Params:
            addr (address) - The address.
            error (uint16) - An error code.
    */
    event AddOwner(address indexed newRoot, uint16 indexed error);

    /*
        Event: RemoveOwner

        Params:
            addr (address) - The address.
            error (uint16) - An error code.
    */
    event RemoveOwner(address indexed newRoot, uint16 indexed error);

    // TODO this should really be two interfaces.

    /*
        Function: setRoot

        Set the root account address.

        Params:
            newRoot (address) - The new root-address.

        Returns:
            error (uint16) - An error code.
    */
    function setRoot(address newRoot) constant returns (uint16 error);

    /*
        Function: root

        Get the root address.

        Returns:
            root (address) - The root-address.
    */
    function root() constant returns (address root);

    /*
        Function: rootData

        Get the root data.

        Returns:
            root (address) - The root-address.
            timeRootAdded (uint) - The unix timestamp of when the address was set.
    */
    function rootData() constant returns (address root, uint timeRootAdded);

    /*
        Function: addOwner

        Add a new owner.

        Params:
            addr (address) - The address of the owner.

        Returns:
            error (uint16) - An error code.
    */
    function addOwner(address addr) returns (uint16 error);

    /*
        Function: removeOwner

        Remove an owner.

        Params:
            addr (address) - The address of the owner.

        Returns:
            error (uint16) - An error code.
    */
    function removeOwner(address addr) returns (uint16 error);

    /*
        Function: ownerTimestamp

        Get the time when the owner was added.

        Params:
            addr (address) - The address of the owner.

        Returns:
            timestamp (uint) - The unix timestamp of when the owner was added.
            error (uint16) - An error code.
    */
    function ownerTimestamp(address addr) constant returns (uint timestamp, uint16 error);

    /*
        Function: ownerFromIndex

        Get the owner with position 'index' in the backing array.

        Params:
            index (uint) - The index.

        Returns:
            owner (address) - The owner address.
            timestamp (uint) - The unix timestamp of when the owner was added.
            error (uint16) - An error code.
    */
    function ownerFromIndex(uint index) constant returns (address owner, uint timestamp, uint16 error);

    /*
        Function: numOwners

        Get the total number of owners.

        Returns:
            numOwners (uint) - The number of owners.
    */
    function numOwners() constant returns (uint numOwners);

    /*
        Function: hasPermission

        Check if an account has this permission. That means they're either an owner or root.

        Params:
            addr (address) - The account address.

        Returns:
            hasPerm (bool) - 'true' if the address is either root or an owner, otherwise 'false'.
    */
    function hasPermission(address addr) constant returns (bool hasPerm);

}