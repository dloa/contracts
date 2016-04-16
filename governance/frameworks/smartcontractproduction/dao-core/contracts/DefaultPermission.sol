/*
    File: DefaultPermission.sol

    Author: Andreas Olofsson (androlo1980@gmail.com)
*/
import "dao-stl/src/errors/Errors";
import "dao-stl/src/contracts/Destructible";
import "Permission";
import "Doug";

/*
    Contract: DefaultPermission

    Default permission contract.

    Root is the only account allowed to add and and remove owners.

    Root and owners all pass the 'isPermission' check.

    All addresses must be valid. If root is not valid, root can not be changed so the entire system breaks down.
*/
contract DefaultPermission is Destructible, Permission, Errors {

    /*
        Struct: OElement

        Element type for OMap. Keeps a key index for iteration, and the timestamp of the owner as data.
    */
    struct OElement {
        uint _keyIndex;
        uint timestamp;
    }

    /*
        Struct: OMap

        Keeps an address -> OElement mapping, and an array of keys (addresses) to enable iteration.
    */
    struct OMap
    {
        mapping(address => OElement) _data;
        address[] _keys;
    }

    address _root;
    uint _timeRootAdded;

    OMap _owners;

    /*
        Constructor:  DefaultDoug

        Params:
            root (address) - The initial root-address.

    */
    function DefaultPermission(address root) {
        _root = root;
        _timeRootAdded = block.timestamp;
    }

    /*
        Function: setRoot

        Set the root account address. Can only be done when caller is 'root'.

        Params:
            newRoot (address) - The new root-address.

        Returns:
            error (uint16) - An error code.
    */
    function setRoot(address newRoot) constant returns (uint16 error) {
        if (msg.sender != _root)
            error = ACCESS_DENIED;
         else {
            _root = newRoot;
            // Remove new root from owner list if he was in there.
            if (_owners._data[newRoot].timestamp != 0)
                delete _owners._data[newRoot];
            _timeRootAdded = block.timestamp;
        }
        SetRoot(newRoot, error);
    }


    /*
        Function: root

        Get the root address.

        Returns:
            root (address) - The root-address.
    */
    function root() constant returns (address root) {
        return _root;
    }

    /*
        Function: rootData

        Get the root data.

        Returns:
            root (address) - The root-address.
            timeRootAdded (uint) - The unix timestamp of when the address was set.
    */
    function rootData() constant returns (address root, uint timeRootAdded) {
        return (_root, _timeRootAdded);
    }

    /*
        Function: addOwner

        Add a new owner. Can only be done by 'root'.

        Params:
            addr (address) - The address of the owner.

        Returns:
            error (uint16) - An error code.
    */
    function addOwner(address addr) returns (uint16 error) {
        // Basic check for null value.
        if (addr == 0)
            error = NULL_PARAM_NOT_ALLOWED;
        else if (addr == _root)
            error = INVALID_PARAM_VALUE;
        // If sender isn't root they can't add new owners.
        else if (msg.sender != _root)
            error = ACCESS_DENIED;
        // If owner exists
        else if (_owners._data[addr].timestamp != 0)
            error = RESOURCE_ALREADY_EXISTS;
        else
            _owners._data[addr] = OElement(_owners._keys.push(addr) - 1, block.timestamp);
        AddOwner(addr, error);
    }

    /*
        Function: removeOwner

        Remove an owner. Can only be done by 'root' and the owner himself.

        Params:
            addr (address) - The address of the owner.

        Returns:
            error (uint16) - An error code.
    */
    function removeOwner(address addr) returns (uint16 error) {
        // Basic check for null value.
        if (addr == 0)
            error = NULL_PARAM_NOT_ALLOWED;
        // If sender isn't an owner of 'perm' (or root) they can't add new owners.
        else if (msg.sender != _root && msg.sender != addr)
            error = ACCESS_DENIED;
        else {
            var elem = _owners._data[addr];

            var exists = elem.timestamp != 0;
            if (!exists)
                error = RESOURCE_NOT_FOUND;
            else {
                var keyIndex = elem._keyIndex;
                delete _owners._data[addr];
                var len = _owners._keys.length;
                if (keyIndex != len - 1) {
                    var swap = _owners._keys[len - 1];
                    _owners._keys[keyIndex] = swap;
                    _owners._data[swap]._keyIndex = keyIndex;
                }
            }
            _owners._keys.length--;
        }
        RemoveOwner(addr, error);
    }

    /*
        Function: ownerTimestamp

        Get the time when the owner was added.

        Params:
            addr (address) - The address of the owner.

        Returns:
            timestamp (uint) - The unix timestamp of when the owner was added.
            error (uint16) - An error code.
    */
    function ownerTimestamp(address addr) constant returns (uint timestamp, uint16 error) {
        timestamp = _owners._data[addr].timestamp;
        if (timestamp == 0)
            error = RESOURCE_NOT_FOUND;
    }

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
    function ownerFromIndex(uint index) constant returns (address owner, uint timestamp, uint16 error) {
        if (index >= _owners._keys.length){
            error = ARRAY_INDEX_OUT_OF_BOUNDS;
            return;
        }
        var addr = _owners._keys[index];
        return (addr, _owners._data[addr].timestamp, NO_ERROR);
    }

    /*
        Function: numOwners

        Get the total number of owners.

        Returns:
            numOwners (uint) - The number of owners.
    */
    function numOwners() constant returns (uint numOwners) {
        return _owners._keys.length;
    }

    /*
        Function: hasPermission

        Check if an account has this permission. That means they're either an owner or root.

        Params:
            addr (address) - The account address.

        Returns:
            hasPerm (bool) - 'true' if the address is either root or an owner, otherwise 'false'.
    */
    function hasPermission(address addr) constant returns (bool hasPerm) {
        return addr == _root || _owners._data[addr].timestamp != 0;
    }

     /*
        Function: destroy

        Destroys the contract if the caller has root permission. Fires a <Destructible.Destroy> event.

        WARNING: May lock down any system that depends on this contract for permissions management.

        Params:
            fundReceiver (address) - The account that receives the funds.
    */
    function destroy(address fundReceiver) {
        if (msg.sender == _root) {
            Destroy(fundReceiver, this.balance, NO_ERROR);
            destroy(fundReceiver);
        }
        else
            Destroy(fundReceiver, 0, ACCESS_DENIED);
    }

}
