/*
    File: DefaultDoug.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
import "dao-stl/src/errors/Errors";
import "Doug";
import "Permission";

/*
    Contract: DefaultDoug

    Default implementation of the 'Doug' interface-contract.

    Contracts are registered using a bi-directional bytes32<->address map, and can be referenced
    either by ID or by address. There is also an array of IDs that enables iteration.

    Adding, removing and getting contracts from the registries are all O(1).

    Contracts can only be given one id, and each id is unique.

    Most collections work is done internally rather then through a library.
*/
contract DefaultDoug is Doug, Errors {

    address constant ADDRESS_NULL = 0;
    bytes32 constant BYTES32_NULL = 0;

    bool _destroyRemovedActions;
    bool _destroyRemovedDatabases;

    Permission _permission;

    /*
        Struct: NAElement

        Element type for NAMap
    */
    struct NAElement {
        uint _keyIndex;
        address value;
    }

    /*
        Struct: NAMap

        Keeps bi-directoinal mappings between contract ids (bytes32) and addresses.
        Also keeps an array of all ids for iteration.
    */
    struct NAMap
    {
        mapping(address => bytes32) _aToN;
        mapping(bytes32 => NAElement) _data;
        bytes32[] _keys;
    }

    NAMap _aMap;
    NAMap _dMap;

    /*
        Constructor:  DefaultDoug

        Check if the caller is registered as an actions contract in doug.

        Params:
            permissionAddress (address) - The address to the permission contract.
            destroyActions (bool) - Whether or not actions-contracts should be destroyed when removed.
            destroyDatabases (bool) - Whether or not database-contracts should be destroyed when removed.

    */
    function DefaultDoug(address permissionAddress, bool destroyActions, bool destroyDatabases) {
        _permission = Permission(permissionAddress);
        _destroyRemovedActions = destroyActions;
        _destroyRemovedDatabases = destroyDatabases;
    }

    // *********************************** Actions contracts ************************************

    /*
        Function: addActionsContract

        Add a new contract to the registry.

        Fires off an <ActionsContractRegistry.AddActionsContract> event if successful.

        Params:
            identifier (bytes32) - The identifier (name).
            contractAddress (address) - The contract address.

        Returns:
            error (uint16) - An error code.
    */
    function addActionsContract(bytes32 identifier, address contractAddress) external returns (uint16 error) {
        address oldAddress;
        (oldAddress, error) = _addContract(_aMap, identifier, contractAddress);
        if (oldAddress != ADDRESS_NULL && _destroyRemovedActions) {
            Destructible(contractAddress).destroy(_permission.root());
            RemoveActionsContract(identifier, oldAddress, NO_ERROR);
        }
        AddActionsContract(identifier, contractAddress, error);

    }

    /*
        Function: removeActionsContract

        Remove a contract from the registry.

        Fires off an <ActionsContractRegistry.RemoveActionsContract> event if successful.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            error (uint16) - An error code.
    */
    function removeActionsContract(bytes32 identifier) external returns (uint16 error) {
        var (addr, err) = _removeContract(_aMap, identifier);
        if (err == NO_ERROR) {
            if (_destroyRemovedActions)
                Destructible(addr).destroy(_permission.root());
        }
        RemoveActionsContract(identifier, addr, err);
        return err;
    }

    /*
        Function: actionsContractAddress

        Get the address of the contract with the given id.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            contractAddress (address) - The address (can be null).
    */
    function actionsContractAddress(bytes32 identifier) constant returns (address contractAddress) {
         return _aMap._data[identifier].value;
    }

    /*
        Function: actionsContractId

        Get the id of the contract with the given address.

        Params:
            contractAddress (address) - The contract address.

        Returns:
            identifier (bytes32) - The id (can be null).
    */
    function actionsContractId(address contractAddress) constant returns (bytes32 identifier) {
         return _aMap._aToN[contractAddress];
    }

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
    function actionsContractFromIndex(uint index) constant returns (bytes32 identifier, address contractAddress, uint16 error) {
        return _contractFromIndex(_aMap, index);
    }

    /*
        Function: numActionsContracts

        Get the number of contracts in the registry.

        Returns:
            numContracts (uint) - The number of actions-contracts.
    */
    function numActionsContracts() constant returns (uint numContracts) {
        return _aMap._keys.length;
    }

    /*
        Function: setDestroyRemovedActions

        Enable to call 'destroy' method on contracts.

        Params:
            destroyRemovedActions (bool) - Whether or not actions-contracts is destroyed when removed.

        Returns:
            error - (uint16) An error code.
    */
    function setDestroyRemovedActions(bool destroyRemovedActions) returns (uint16 error) {
        if (!_hasDougPermission())
            error = ACCESS_DENIED;
        else
            _destroyRemovedActions = destroyRemovedActions;
        SetDestroyRemovedActions(destroyRemovedActions, error);
    }

    /*
        Function: destroyRemovedActions

        Check if contracts are automatically destroyed when removed.

        Returns:
            destroyRemovedActions (bool) - Whether or not actions-contracts is destroyed when removed.
    */
    function destroyRemovedActions() constant returns (bool destroyRemovedActions) {
        return _destroyRemovedActions;
    }

    // *********************************** Database contracts ************************************

    /*
        Function: addDatabaseContract

        Add a new contract to the registry.

        Fires off an <DatabaseContractRegistry.AddDatabaseContract> event if successful.

        Params:
            identifier (bytes32) - The identifier (name).
            contractAddress (address) - The contract address.

        Returns:
            error (uint16) - An error code.
    */
    function addDatabaseContract(bytes32 identifier, address contractAddress) external returns (uint16 error) {
        address oldAddress;
        (oldAddress, error) = _addContract(_dMap, identifier, contractAddress);
        if (oldAddress != ADDRESS_NULL && _destroyRemovedDatabases) {
            Destructible(contractAddress).destroy(_permission.root());
            RemoveDatabaseContract(identifier, oldAddress, NO_ERROR);
        }
        AddDatabaseContract(identifier, contractAddress, error);
    }

    /*
        Function: removeDatabaseContract

        Remove a contract from the registry.

        Fires off an <DatabaseContractRegistry.RemoveDatabaseContract> event if successful.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            error (uint16) - An error code.
    */
    function removeDatabaseContract(bytes32 identifier) external returns (uint16 error) {
        var (addr, err) = _removeContract(_dMap, identifier);
        if (err == NO_ERROR) {
            if (_destroyRemovedDatabases)
                Destructible(addr).destroy(_permission.root());
        }
        RemoveDatabaseContract(identifier, addr, err);
        return err;
    }

    /*
        Function: databaseContractAddress

        Get the address of the contract with the given id.

        Params:
            identifier (bytes32) - The identifier (name).

        Returns:
            contractAddress (address) - The address (can be null).
    */
    function databaseContractAddress(bytes32 identifier) constant returns (address contractAddress) {
         return _dMap._data[identifier].value;
    }

    /*
        Function: databaseContractId

        Get the id of the contract with the given address.

        Params:
            contractAddress (address) - The contract address.

        Returns:
            identifier (bytes32) - The id (can be null).
    */
    function databaseContractId(address contractAddress) constant returns (bytes32 identifier) {
         return _dMap._aToN[contractAddress];
    }

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
    function databaseContractFromIndex(uint index) constant returns (bytes32 identifier, address contractAddress, uint16 error) {
        return _contractFromIndex(_dMap, index);
    }

    /*
        Function: numDatabaseContracts

        Get the number of contracts in the registry.

        Returns:
            numContracts (uint) - The number of contracts.
    */
    function numDatabaseContracts() constant returns (uint numContracts) {
        return _dMap._keys.length;
    }

    /*
        Function: setDestroyRemovedDatabases

        Enable to call 'destroy' method on contracts.

        Params:
            destroyRemovedDatabases (bool) - Whether or not database-contracts are destroyed when removed.

        Returns:
            error (uint16) - An error code.
    */
    function setDestroyRemovedDatabases(bool destroyRemovedDatabases) returns (uint16 error) {
        if (!_hasDougPermission())
            error = ACCESS_DENIED;
        else
            _destroyRemovedDatabases = destroyRemovedDatabases;
        SetDestroyRemovedDatabases(destroyRemovedDatabases, error);
    }

    /*
        Function: destroyRemovedDatabase

        Check if contracts are automatically destroyed when removed.

        Returns:
            destroyRemovedDatabase (bool) - Whether or not database-contracts are destroyed when removed.
    */
    function destroyRemovedDatabases() constant returns (bool destroyRemovedDatabases) {
        return _destroyRemovedDatabases;
    }

    // *********************************** Doug specific ************************************

    /*
        Function: setPermission

        Set the permission contract address.

        Params:
            permissionAddress (address) - The address to the permission contract.

        Returns:
            error (uint16) - An error code.
    */
    function setPermission(address permissionAddress) returns (uint16 error) {
        // Only allow
        if (address(_permission) != ADDRESS_NULL && msg.sender != _permission.root())
            error = ACCESS_DENIED;
        else
            _permission = Permission(permissionAddress);
        SetPermission(permissionAddress, error);
    }

    /*
        Function: permissionAddress

        Get the address of the permission contract.

        Params:
            permissionAddress (address) the address to the permission contract.

        Returns:
            pmAddress (address) - The address of the permissions contract.
    */
    function permissionAddress() constant returns (address pmAddress) {
        return _permission;
    }

     /*
        Function: destroy

        Destroys the contract if the caller has root permission. Fires a <Destructible.Destroy> event.

        WARNING: Will destroy the entire system. Should not be done until all managed contracts are destroyed.

        Params:
            fundReceiver (address) - The account that receives the funds.
    */
    function destroy(address fundReceiver) {
        if (msg.sender == _permission.root()) {
            Destroy(fundReceiver, this.balance, NO_ERROR);
            destroy(fundReceiver);
        }
        else
            Destroy(fundReceiver, 0, ACCESS_DENIED);
    }

    // *********************************** Internal ************************************

     /*
        Function: _addContract

        Add a contract.

        Params:
            map (<NaMap>) - The map (either actions or databases).
            identifier (bytes32) - The contract id.
            contractAddress (address) - The contract address.

        Returns:
            oldAddress (address) - The address of the replaced contract, if any.
            error (uint16) - An error code.
    */
    function _addContract(NAMap storage map, bytes32 identifier, address contractAddress) internal returns (address oldAddress, uint16 error) {

        if (!_hasDougPermission()) {
            error = ACCESS_DENIED;
            return;
        }
        // Neither the ID nor the address can be null.
        if (identifier == BYTES32_NULL || contractAddress == ADDRESS_NULL) {
            error = NULL_PARAM_NOT_ALLOWED;
            return;
        }

        // TODO try-catch later.
        address sda = DougEnabled(contractAddress).setDougAddress(this);

        // If failing the doug-address check - break.
        if (sda != address(this)) {
            // Come up with something better here.
            error = PARAMETER_ERROR;
            return;
        }

        oldAddress = map._data[identifier].value;

        var exists = oldAddress != ADDRESS_NULL;

        if (exists) {
            map._data[identifier].value = contractAddress;
            delete map._aToN[oldAddress];
        }
        else {
            // Register address under the given ID.
            map._data[identifier] = NAElement(map._keys.push(identifier) - 1, contractAddress);
        }
        // Register ID under the given address.
        map._aToN[contractAddress] = identifier;
    }

     /*
        Function: _removeContract

        Remove a contract.

        Params:
            map (<NaMap>) - The map (either actions or databases).
            identifier (bytes32) - The contract id.

        Returns:
            addr (address) - The address of the removed contract.
            error (uint16) - An error code.
    */
    function _removeContract(NAMap storage map, bytes32 identifier) internal returns (address addr, uint16 error) {
        if (!_hasDougPermission()) {
            error = ACCESS_DENIED;
            return;
        }
        if (identifier == BYTES32_NULL) {
            error = NULL_PARAM_NOT_ALLOWED;
            return;
        }
        var elem = map._data[identifier];
        addr = elem.value;
        var exists = addr != ADDRESS_NULL;
        if (!exists) {
            error = RESOURCE_NOT_FOUND;
            return;
        }
        var keyIndex = elem._keyIndex;
        delete map._data[identifier];
        delete map._aToN[addr];
        var len = map._keys.length;
        if (keyIndex != len - 1) {
            var swap = map._keys[len - 1];
            map._keys[keyIndex] = swap;
            map._data[swap]._keyIndex = keyIndex;
        }
        map._keys.length--;
    }

     /*
        Function: _contractFromIndex

        Get a contract from its index in the backing array of the provided map.

        Params:
            map (<NaMap>) - The map (either actions or databases).
            index (uint) - The index.

        Returns:
            identifier (bytes32) - The contract id.
            contractAddress (address) - The contract address.
            error (uint16) - An error code.
    */
    function _contractFromIndex(NAMap storage map, uint index) internal constant returns (bytes32 identifier, address contractAddress, uint16 error) {
        if (index >= map._keys.length) {
            error = ARRAY_INDEX_OUT_OF_BOUNDS;
            return;
        }
        var id = map._keys[index];
        return (id, map._data[id].value, NO_ERROR);
    }

     /*
        Function: _hasDougPermission

        Check if the caller has the doug permission.

        Returns:
            hasDougPermission (bool) - 'true' if the caller has the doug permission.
    */
    function _hasDougPermission() constant internal returns (bool hasDougPermission) {
        return address(_permission) != 0 && _permission.hasPermission(msg.sender);
    }

}
