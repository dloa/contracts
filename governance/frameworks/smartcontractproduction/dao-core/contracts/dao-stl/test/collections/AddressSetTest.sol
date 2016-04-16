import "dao-stl/src/collections/AddressSet";
import "dao-stl/src/assertions/Test";

contract AddressSetDb {

    event AddAddress(bool indexed added);
    event RemoveAddress(bool indexed removed);

    using AddressSet for AddressSet.Set;

    AddressSet.Set _set;

    function addAddress(address addr) returns (bool added) {
        added = _set.insert(addr);
        AddAddress(added);
    }

    function removeAddress(address addr) returns (bool removed) {
        removed = _set.remove(addr);
        RemoveAddress(removed);
    }

    function hasAddress(address addr) constant returns (bool has) {
        return _set.hasValue(addr);
    }

    function addressFromIndex(uint index) constant returns (address addr, bool has) {
        return _set.valueFromIndex(index);
    }

    function numAddresses() constant returns (uint setSize) {
        return _set.size();
    }
}


contract AddressSetTest is Test {

    address constant TEST_ADDRESS = 0x12345;
    address constant TEST_ADDRESS_2 = 0xABCDEF;
    address constant TEST_ADDRESS_3 = 0xC0FFEE;

    function testInsert() {
        var asdb = new AddressSetDb();
        
        asdb.addAddress(TEST_ADDRESS).assert("addAddress does not return true");
        asdb.hasAddress(TEST_ADDRESS).assert("hasAddress does not return true");
        var (a, e) = asdb.addressFromIndex(0);
        e.assert("addressFromIndex exist is false");
        a.assertEqual(TEST_ADDRESS, "addressFromIndex returns the wrong address");
        asdb.numAddresses().assertEqual(1, "size is wrong");
    }

    function testRemoveAddress() {
        var asdb = new AddressSetDb();
        asdb.addAddress(TEST_ADDRESS);

        asdb.removeAddress(TEST_ADDRESS).assert("removeAddress does not return true");
        asdb.hasAddress(TEST_ADDRESS).assertFalse("hasAddress does not return false");
        var (a, e) = asdb.addressFromIndex(0);
        e.assertFalse("addressFromIndex exist is true");
        a.assertZero("addressFromIndex returns non-zero address");
        asdb.numAddresses().assertZero("size is not zero");
    }

    function testAddTwoAddresses() {
        var asdb = new AddressSetDb();
        asdb.addAddress(TEST_ADDRESS);

        asdb.addAddress(TEST_ADDRESS_2).assert("addAddress does not return true for second element");
        asdb.hasAddress(TEST_ADDRESS).assert("hasAddress does not return true for first element");
        asdb.hasAddress(TEST_ADDRESS_2).assert("hasAddress does not return true for second element");

        var (a, e) = asdb.addressFromIndex(0);
        e.assert("addressFromIndex exist is false for first element");
        a.assertEqual(TEST_ADDRESS, "addressFromIndex returns the wrong address for first element");
        (a, e) = asdb.addressFromIndex(1);
        e.assert("addressFromIndex exist is false for second element");
        a.assertEqual(TEST_ADDRESS_2, "addressFromIndex returns the wrong address for second element");

        asdb.numAddresses().assertEqual(2, "size is wrong");
    }

    function testAddTwoAddressesRemoveLast() {
        var asdb = new AddressSetDb();
        asdb.addAddress(TEST_ADDRESS);
        asdb.addAddress(TEST_ADDRESS_2);
        asdb.removeAddress(TEST_ADDRESS_2);

        asdb.hasAddress(TEST_ADDRESS).assert("hasAddress does not return true for first element");
        asdb.hasAddress(TEST_ADDRESS_2).assertFalse("hasAddress does not return false for second element");

        var (a, e) = asdb.addressFromIndex(0);
        e.assert("addressFromIndex exist is false for first element");
        a.assertEqual(TEST_ADDRESS, "addressFromIndex returns the wrong address for first element");
        (a, e) = asdb.addressFromIndex(1);
        e.assertFalse("addressFromIndex exist is true for second element");
        a.assertZero("addressFromIndex returns the wrong address for second element");

        asdb.numAddresses().assertEqual(1, "size is not 1");
    }

    function testAddTwoAddressesRemoveFirst() {
        var asdb = new AddressSetDb();
        asdb.addAddress(TEST_ADDRESS);
        asdb.addAddress(TEST_ADDRESS_2);
        asdb.removeAddress(TEST_ADDRESS);

        asdb.hasAddress(TEST_ADDRESS).assertFalse("hasAddress does not return false for first element");
        asdb.hasAddress(TEST_ADDRESS_2).assert("hasAddress does not return true for second element");

        var (a, e) = asdb.addressFromIndex(0);
        e.assert("addressFromIndex exist is false for first element");
        a.assertEqual(TEST_ADDRESS_2, "addressFromIndex returns the wrong address for first element");
        (a, e) = asdb.addressFromIndex(1);
        e.assertFalse("addressFromIndex exist is true for second element");
        a.assertZero("addressFromIndex returns the wrong address for second element");

        asdb.numAddresses().assertEqual(1, "size is not 1");
    }

    function testAddThreeAddressesRemoveMiddle() {
        var asdb = new AddressSetDb();
        asdb.addAddress(TEST_ADDRESS);
        asdb.addAddress(TEST_ADDRESS_2);
        asdb.addAddress(TEST_ADDRESS_3);
        asdb.removeAddress(TEST_ADDRESS_2);

        asdb.hasAddress(TEST_ADDRESS).assert("hasAddress does not return true for first element");
        asdb.hasAddress(TEST_ADDRESS_2).assertFalse("hasAddress does not return false for second element");
        asdb.hasAddress(TEST_ADDRESS_3).assert("hasAddress does not return true for third element");

        var (a, e) = asdb.addressFromIndex(0);
        e.assert("addressFromIndex exist is false for first element");
        a.assertEqual(TEST_ADDRESS, "addressFromIndex returns the wrong address for first element");

        (a, e) = asdb.addressFromIndex(1);
        e.assert("addressFromIndex exist is false for second element");
        a.assertEqual(TEST_ADDRESS_3, "addressFromIndex returns the wrong address for second element");

        (a, e) = asdb.addressFromIndex(2);
        e.assertFalse("addressFromIndex exist is true for third element");
        a.assertZero("addressFromIndex returns the wrong address for third element");
    }

}
