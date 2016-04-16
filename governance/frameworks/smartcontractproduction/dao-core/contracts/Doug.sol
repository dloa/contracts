/*
    File: Doug.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
import "Permission";
import "dao-stl/src/errors/Errors";
import "dao-stl/src/contracts/Destructible";

/*
    Contract: DougEnabled

    This interface must be implemented by contracts that are used as doug
    actions or database contracts.
*/
contract DougEnabled is Destructible {

    // TODO use try-catch in Doug instead, when that is added.
    /*
        Function: setDougAddress

        Set the address of the Doug contract. Will fail if address is already set, or if input address is null.

        Params:
            dougAddr (address) - The Doug-address.

        Returns:
            doug (address) - An address. 0 means null param, doug != dougAddr means some other doug address is in use.
    */
    function setDougAddress(address dougAddr) returns (address doug);

    /*
        Function: dougAddress

        Get the address of the Doug contract.

        Returns:
            dougAddress (address) - The Doug-address.
    */
    function dougAddress() constant returns (address dougAddress);

}


/*
    Contract: ActionsContractRegistry

    The ActionsContractRegistry is an interface for contracts that has an iterable registry of actions contracts.
*/
contract ActionsContractRegistry {

    /*
        Event: AddActionsContract

        Params:
            contractId (bytes32) - The id of the contract.
            contractAddress (address) - The address of the contract.
            error (uint16) - An error code.
    */
    event AddActionsContract(bytes32 indexed contractId, address indexed contractAddress, uint16 indexed error);

    /*
        Event: RemovedActionsContract

        Params:
            contractId (bytes32) - The id of the contract.
            contractAddress (address) - The address of the contract.
            error (uint16) - An error code.
    */
    event RemoveActionsContract(bytes32 indexed contractId, address indexed contractAddress, uint16 indexed error);

    /*
        Event: SetDestroyRemovedActions

        Params:
            destroyRemovedActions (bool) - Whether or not to destroy removed actions.
            error (uint16) - An error code.
    */
    event SetDestroyRemovedActions(bool indexed destroyRemovedActions, uint16 indexed error);

    /*
        Function: addActionsContract

        Add a new contract to the registry.

        Params:
            identifier (bytes32) - The identifier (name).
            contractAddress (address) - The contract address.

        Returns:
            error (uint16) - An error code.
    */
    function addActionsContract(bytes32 identifier, address contractAddress) external returns (uint16 error);

    /*
        Function: removeActionsContract

        Remove a contract from the registry.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            error (uint16) - An error code.
    */
    function removeActionsContract(bytes32 identifier) external returns (uint16 error);

    /*
        Function: actionsContractAddress

        Get the address of the contract with the given id.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            contractAddress (address) - The address (can be null).
    */
    function actionsContractAddress(bytes32 identifier) constant returns (address contractAddress);

    /*
        Function: actionsContractId

        Get the id of the contract with the given address.

        Params:
            contractAddress (address) - The contract address.

        Returns:
            identifier (bytes32) - The id (can be null).
    */
    function actionsContractId(address contractAddress) constant returns (bytes32 identifier);

    /*
        Function: actionsContractFromIndex

        Get the id and address of the contract with the given index.

        Params:
            index (uint) - The index.

        Returns:
            identifier (bytes32) - The id (can be null).
            contractAddress (address) - The address (can be null).
            error (uint16) - An error code.
    */
    function actionsContractFromIndex(uint index) constant returns (bytes32 identifier, address contractAddress, uint16 error);

    /*
        Function: numActionsContracts

        Get the number of contracts in the registry.

        Returns:
            numContracts (uint) - The number of actions-contracts.
    */
    function numActionsContracts() constant returns (uint numContracts);

    /*
        Function: setDestroyRemovedActions

        Enable to call 'destroy' method on contracts.

        Params:
            destroyRemovedActions (bool) - Whether or not actions-contracts is destroyed when removed.

        Returns:
            error - (uint16) An error code.
    */
    function setDestroyRemovedActions(bool destroyRemovedActions) returns (uint16 error);

    /*
        Function: destroyRemovedActions

        Check if contracts are automatically destroyed when removed.

        Returns:
            destroyRemovedActions (bool) - Whether or not actions-contracts is destroyed when removed.
    */
    function destroyRemovedActions() constant returns (bool destroyRemovedActions);

}

/*
    Contract: DatabaseContractRegistry

    The DatabaseContractRegistry is an interface for contracts that has an iterable registry of database contracts.
*/
contract DatabaseContractRegistry {

    /*
        Event: AddDatabaseContract

        Params:
            contractId (bytes32) - The id of the contract.
            contractAddress (address) - The address of the contract.
            error (uint16) - An error code.
    */
    event AddDatabaseContract(bytes32 indexed contractId, address indexed contractAddress, uint16 indexed error);

    /*
        Event: RemoveDatabaseContract

        Params:
            contractId (bytes32) - The id of the contract.
            contractAddress (address) - The address of the contract.
            error (uint16) - An error code.
    */
    event RemoveDatabaseContract(bytes32 indexed contractId, address indexed contractAddress, uint16 indexed error);

    /*
        Event: SetDestroyRemovedDatabases

        Params:
            destroyRemovedDatabases (bool) - Whether or not to destroy removed databases.
            error (uint16) - An error code.
    */
    event SetDestroyRemovedDatabases(bool indexed destroyRemovedDatabases, uint16 indexed error);

    /*
        Function: addDatabaseContract

        Add a new contract to the registry.

        Params:
            identifier (bytes32) - The identifier (name).
            contractAddress (address) - The contract address.

        Returns:
            error (uint16) - An error code.
    */
    function addDatabaseContract(bytes32 identifier, address contractAddress) external returns (uint16 error);

    /*
        Function: removeDatabaseContract

        Remove a contract from the registry.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            error (uint16) - An error code.
    */
    function removeDatabaseContract(bytes32 identifier) external returns (uint16 error);

    /*
        Function: databaseContractAddress

        Get the address of the contract with the given id.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            contractAddress (address) - The address (can be null).
    */
    function databaseContractAddress(bytes32 identifier) constant returns (address contractAddress);

    /*
        Function: databaseContractId

        Get the id of the contract with the given address.

        Params:
            contractAddress (address) - The contract address.

        Returns:
            identifier (bytes32) - The id (can be null).
    */
    function databaseContractId(address contractAddress) constant returns (bytes32 identifier);

    /*
        Function: databaseContractFromIndex

        Get the id and address of the contract with the given index.

        Params:
            index (uint) - The index.

        Returns:
            identifier (bytes32) - The id (can be null).
            contractAddress (address) - The address (can be null).
            error (uint16) - An error code.
    */
    function databaseContractFromIndex(uint index) constant returns (bytes32 identifier, address contractAddress, uint16 error);

    /*
        Function: numDatabaseContracts

        Get the number of contracts in the registry.

        Returns:
            numContracts (uint) - The number of contracts.
    */
    function numDatabaseContracts() constant returns (uint numContracts);

    /*
        Function: setDestroyRemovedDatabase

        Enable to call 'destroy' method on contracts.

        Params:
            destroyRemovedDatabase (bool) - Whether or not database-contracts are destroyed when removed.

        Returns:
            error (uint16) - An error code.
    */
    function setDestroyRemovedDatabases(bool destroyRemovedDatabases) returns (uint16 error);

    /*
        Function: destroyRemovedDatabases

        Check if contracts are automatically destroyed when removed.

        Returns:
            destroyRemovedDatabases (bool) - Whether or not database-contracts are destroyed when removed.
    */
    function destroyRemovedDatabases() constant returns (bool destroyRemovedDatabases);

}

/*
    Contract: Doug

    Doug is an interface for the top level contract in a DApp. It has registries for contracts
    and a permissions manager. Contract IDs are 32 byte strings (bytes32).
*/
contract Doug is ActionsContractRegistry, DatabaseContractRegistry, Destructible {

    /*
        Event: SetPermission

        Params:
            permissionAddress (address) - The address of the contract.
            error (uint16) - An error code.
    */
    event SetPermission(address indexed permissionAddress, uint16 indexed error);

    /*
        Function: setPermission

        Set the permission contract address.

        Params:
            permissionAddress (address) - The address to the permission contract.

        Returns:
            error (uint16) - An error code.
    */
    function setPermission(address permissionAddress) returns (uint16 error);

    /*
        Function: permissionAddress

        Get the address of the permission contract.

        Params:
            permissionAddress (address) the address to the permission contract.

        Returns:
            pmAddress (address) - The address of the permissions contract.
    */
    function permissionAddress() constant returns (address pmAddress);

}

/*
    Contract: DefaultDougEnabled

    Default implementation of 'DougEnabled'.
*/
contract DefaultDougEnabled is DougEnabled, Errors {

    Doug _DOUG;

    /*
        Function: setDougAddress

        Set the address of the Doug contract. Will fail if address is already set, or if input address is null.

        Params:
            dougAddr (address) - The Doug-address.

        Returns:
            doug (address) - An address. 0 means null param, doug != dougAddr means some other doug address is in use.
    */
    function setDougAddress(address dougAddr) returns (address doug) {
        // If dougAddr is zero.
        if (dougAddr == 0)
            return;
        // If Doug is set, only change it if the caller is the current Doug.
        if(address(_DOUG) != 0x0 && address(_DOUG) != msg.sender)
            return address(_DOUG);
        _DOUG = Doug(dougAddr);
        return dougAddr;
    }

    /*
        Function: dougAddress

        Get the address of the Doug contract.

        Returns:
            dougAddress (address) - The Doug-address.
    */
    function dougAddress() constant returns (address dougAddress) {
        return _DOUG;
    }

     /*
        Function: destroy

        Destroy a contract. No return values since it's a destruction. Calls 'selfdestruct'
        on the contract if successful. Fires off a <Destroy> event.

        Params:
            fundReceiver (address) - The account that receives the funds.
    */
    function destroy(address fundReceiver) {
        if (msg.sender == address(_DOUG)) {
            Destroy(fundReceiver, this.balance, NO_ERROR);
            destroy(fundReceiver);
        }
        else
            Destroy(fundReceiver, 0, ACCESS_DENIED);
    }

}
