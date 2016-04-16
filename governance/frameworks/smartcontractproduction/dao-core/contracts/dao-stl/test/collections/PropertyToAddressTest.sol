import "dao-stl/src/collections/PropertyToAddressMap.slb";
import "dao-stl/src/assertions/Test.sol";

contract PropertyToAddressDb {

    using PropertyToAddressMap for PropertyToAddressMap.Map;

    PropertyToAddressMap.Map _map;

    function insert(bytes32 key, address value) returns (address oldValue) {
        return _map.insert(key, value);
    }

    function insert(bytes32 key, address value, bool overwrite) returns (address oldValue, bool added) {
        return _map.insert(key, value, overwrite);
    }

    function get(bytes32 key) constant returns (address value){
        return _map.get(key);
    }

    function remove(bytes32 key) returns (address value, bool removed) {
        return _map.remove(key);
    }

    function hasKey(bytes32 key) constant returns (bool has) {
        return _map.hasKey(key);
    }

    function keyFromIndex(uint index) constant returns (bytes32 key, bool has) {
        return _map.keyFromIndex(index);
    }

    function entryFromIndex(uint index) constant returns (bytes32 key, address value, bool has) {
        return _map.entryFromIndex(index);
    }

    function size() constant returns (uint size) {
        return _map.size();
    }
}


contract PropertyToAddressTest is Test {

    address constant TEST_ADDRESS = 0x12345;
    address constant TEST_ADDRESS_2 = 0xABCDEF;
    address constant TEST_ADDRESS_3 = 0xC0FFEE;

    bytes32 constant TEST_BYTES32   = 1;
    bytes32 constant TEST_BYTES32_2 = 2;
    bytes32 constant TEST_BYTES32_3 = 3;

    function testInsert() {
        PropertyToAddressDb padb = new PropertyToAddressDb();

        padb.insert(TEST_BYTES32, TEST_ADDRESS).assertZero("insert returns wrong old address");
        padb.hasKey(TEST_BYTES32).assert("hasKey does not return true");

        var (b, e) = padb.keyFromIndex(0);
        e.assert("keyFromIndex exist is false");
        b.assertEqual(TEST_BYTES32, "keyFromIndex returns the wrong address");
        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS, "get returns the wrong address");
        padb.size().assertEqual(1, "size is not 1");
    }

    function testOverwriteSuccess() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);

        var (old, added) = padb.insert(TEST_BYTES32, TEST_ADDRESS_2, true);
        old.assertEqual(TEST_ADDRESS, "insert returns wrong old address");
        added.assert("added is not true");

        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS_2, "get returns the wrong address");
        padb.size().assertEqual(1, "size is not 1");
    }

    function testOverwriteFail() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);

        var (old, added) = padb.insert(TEST_BYTES32, TEST_ADDRESS_2, false);
        old.assertZero("insert returns wrong old address");
        added.assertFalse("added is true");

        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS, "get returns the wrong address");
        padb.size().assertEqual(1, "size is not 1");
    }

    function testEntryFromIndex() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);

        var (k, v, e) = padb.entryFromIndex(0);
        k.assertEqual(TEST_BYTES32, "entryFromIndex returns the wrong key");
        v.assertEqual(TEST_ADDRESS, "entryFromIndex returns the wrong value");
        e.assert("entryFromIndex returns the wrong existence value");
    }

    function testEntryFromIndexFail() {
        PropertyToAddressDb padb = new PropertyToAddressDb();

        var (k, v, e) = padb.entryFromIndex(0);
        k.assertZero("entryFromIndex returns the wrong key");
        v.assertZero("entryFromIndex returns the wrong value");
        e.assertFalse("entryFromIndex returns the wrong existence value");
    }

    function testRemove() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);

        var (addr, removed) = padb.remove(TEST_BYTES32);
        addr.assertEqual(TEST_ADDRESS, "remove returns the wrong address");
        removed.assert("remove returns the wrong result");
        padb.hasKey(TEST_BYTES32).assertFalse("hasKey returns true");

        var (b, e) = padb.keyFromIndex(0);
        b.assertZero("keyFromIndex returns the wrong key");
        e.assertFalse("keyFromIndex returns the wrong existence value");
        padb.size().assertZero("size is not 0");
    }

    function testAddTwo() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);
        padb.insert(TEST_BYTES32_2, TEST_ADDRESS_2);

        padb.hasKey(TEST_BYTES32).assert("hasKey does not return true for first key.");
        padb.hasKey(TEST_BYTES32).assert("hasKey does not return true for second key.");

        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS, "get returns the wrong value for first entry.");
        padb.get(TEST_BYTES32_2).assertEqual(TEST_ADDRESS_2, "get returns the wrong value for second entry.");

        var (b, e) = padb.keyFromIndex(0);
        e.assert("keyFromIndex exist is false for first entry.");
        b.assertEqual(TEST_BYTES32, "keyFromIndex returns the wrong key for the first entry.");

        (b, e) = padb.keyFromIndex(1);
        e.assert("keyFromIndex exist is false for second entry.");
        b.assertEqual(TEST_BYTES32_2, "keyFromIndex returns the wrong key for second entry.");

        padb.size().assertEqual(2, "size is not 2");
    }

    function testAddTwoRemoveLast() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);
        padb.insert(TEST_BYTES32_2, TEST_ADDRESS_2);
        padb.remove(TEST_BYTES32_2);

        padb.hasKey(TEST_BYTES32).assert("hasKey does not return true for first key.");
        padb.hasKey(TEST_BYTES32_2).assertFalse("hasKey does not return false for second key.");

        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS, "get returns the wrong value for first entry.");
        padb.get(TEST_BYTES32_2).assertZero("get returns the wrong value for second entry.");

        var (b, e) = padb.keyFromIndex(0);
        e.assert("keyFromIndex exist is false for first entry.");
        b.assertEqual(TEST_BYTES32, "keyFromIndex returns the wrong key for the first entry.");
        (b, e) = padb.keyFromIndex(1);
        e.assertFalse("keyFromIndex exist is false for second entry.");
        b.assertZero("keyFromIndex returns the wrong key for second entry.");

        padb.size().assertEqual(1, "size is not 1");
    }

    function testAddTwoRemoveFirst() {
        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);
        padb.insert(TEST_BYTES32_2, TEST_ADDRESS_2);
        padb.remove(TEST_BYTES32);

        padb.hasKey(TEST_BYTES32).assertFalse("hasKey does not return false for first key.");
        padb.hasKey(TEST_BYTES32_2).assert("hasKey does not return true for second key.");

        padb.get(TEST_BYTES32).assertZero("get returns the wrong value for first entry.");
        padb.get(TEST_BYTES32_2).assertEqual(TEST_ADDRESS_2, "get returns the wrong value for second entry.");


        var (b, e) = padb.keyFromIndex(0);
        e.assert("keyFromIndex exist is false for first entry.");
        b.assertEqual(TEST_BYTES32_2, "keyFromIndex returns the wrong key for the first entry.");
        (b, e) = padb.keyFromIndex(1);
        e.assertFalse("keyFromIndex exist is false for second entry.");
        b.assertZero("keyFromIndex returns the wrong key for second entry.");

        padb.size().assertEqual(1, "size is not 1");
    }

    function testAddThreeRemoveMiddle() {

        PropertyToAddressDb padb = new PropertyToAddressDb();
        padb.insert(TEST_BYTES32, TEST_ADDRESS);
        padb.insert(TEST_BYTES32_2, TEST_ADDRESS_2);
        padb.insert(TEST_BYTES32_3, TEST_ADDRESS_3);
        padb.remove(TEST_BYTES32_2);

        padb.hasKey(TEST_BYTES32).assert("hasKey does not return false for first key.");
        padb.hasKey(TEST_BYTES32_2).assertFalse("hasKey does not return false for second key.");
        padb.hasKey(TEST_BYTES32_3).assert("hasKey does not return true for first key.");

        padb.get(TEST_BYTES32).assertEqual(TEST_ADDRESS, "get returns the wrong value for first entry.");
        padb.get(TEST_BYTES32_2).assertZero("get returns the wrong value for second entry.");
        padb.get(TEST_BYTES32_3).assertEqual(TEST_ADDRESS_3, "get returns the wrong value for third entry.");

        var (b, e) = padb.keyFromIndex(0);
        e.assert("keyFromIndex exist is false for first entry.");
        b.assertEqual(TEST_BYTES32, "keyFromIndex returns the wrong key for the first entry.");

        (b, e) = padb.keyFromIndex(1);
        e.assert("keyFromIndex exist is false for second entry.");
        b.assertEqual(TEST_BYTES32_3, "keyFromIndex returns the wrong key for the second entry.");

        (b, e) = padb.keyFromIndex(2);
        e.assertFalse("keyFromIndex exist is false for third entry.");
        b.assertZero("keyFromIndex returns the wrong key for third entry.");

        padb.size().assertEqual(2, "size is not 2");
    }

}