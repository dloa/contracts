import "dao-stl/src/assertions/DaoTest.sol";
import "Doug.sol";
import "DefaultDoug.sol";
import "Permission.sol";

contract MockPermission is Permission, Errors {

    bool _allow;

    function MockPermission(bool allow) {
        _allow = allow;
    }

    function setRoot(address newRoot) constant returns (uint16 error) {
        return NO_ERROR;
    }

    function addOwner(address addr) returns (uint16 error) {
        return NO_ERROR;
    }

    function removeOwner(address addr) returns (uint16 error) {
        return NO_ERROR;
    }

    function ownerFromIndex(uint index) constant returns (address owner, uint timestamp, uint16 error) {
        return;
    }

    function ownerTimestamp(address addr) constant returns (uint timestamp, uint16 error) {
        return;
    }

    function numOwners() constant returns (uint numOwners) {
        return 0;
    }

    function hasPermission(address addr) constant returns (bool hasPerm) {
        return _allow;
    }

    function root() constant returns (address root) {
        return 0;
    }

    function rootData() constant returns (address root, uint timeRootAdded) {
        return;
    }

}


contract MockContract is DefaultDougEnabled {

    function destroy(address fundReceiver){}

}


contract DefaultDougSettable is MockContract {

    function DefaultDougSettable(address addr) {
        _DOUG = Doug(addr);
    }
}
