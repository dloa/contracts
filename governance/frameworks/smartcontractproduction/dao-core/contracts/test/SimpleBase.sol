import "dao-core/src/Database.sol";
import "dao-core/src/DefaultDoug.sol";
import "dao-core/src/DefaultPermission.sol";
// import "dao-stl/src/errors/Errors.sol";

contract SimpleDb is Database {
    function setData(uint data) returns (uint16 error);
    function data() constant returns (uint data);
}

contract DefaultSimpleDb is SimpleDb, DefaultDatabase {

    uint _data;

    function DefaultSimpleDb() DefaultDatabase("simple") {}

    function setData(uint data) returns (uint16 error) {
        if (!_checkCaller())
            error = ACCESS_DENIED;
        else
            _data = data;
    }

    function data() constant returns (uint data) {
        return _data;
    }

}


contract AbstractSimple is DefaultDougEnabled  {

    event AddData(uint indexed data, uint16 error);

    SimpleDb _simpleDb;

    function AbstractSimple(address simpleDb) {
        _simpleDb = SimpleDb(simpleDb);
    }

    function addData(uint data) returns (uint16 error);

}


contract SimpleOne is AbstractSimple {

    function SimpleOne(address simpleDb) AbstractSimple(simpleDb) {}

    function addData(uint data) returns (uint16 error) {
        error = _simpleDb.setData(data);
        AddData(data, error);
    }

}


contract SimpleTwo is AbstractSimple {

    address _owner;

    function SimpleTwo(address simpleDb, address owner) AbstractSimple(simpleDb) {
        _owner = owner;
    }

    function addData(uint data) returns (uint16 error) {
        if (msg.sender != _owner)
            error = ACCESS_DENIED;
        else
            error = _simpleDb.setData(data);
        AddData(data, error);
    }

}