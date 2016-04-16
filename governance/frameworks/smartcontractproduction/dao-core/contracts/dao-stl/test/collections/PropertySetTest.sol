import "dao-stl/src/collections/PropertySet.slb";
import "dao-stl/src/assertions/Test.sol";

contract PropertySetDb {

    using PropertySet for PropertySet.Set;

    PropertySet.Set _set;

    function addProperty(bytes32 prop) returns (bool added) {
        return _set.insert(prop);
    }

    function removeProperty(bytes32 prop) returns (bool removed) {
        return _set.remove(prop);
    }

    function hasProperty(bytes32 prop) constant returns (bool has) {
        return _set.hasValue(prop);
    }

    function propertyFromIndex(uint index) constant returns (bytes32 prop, bool has) {
        return _set.valueFromIndex(index);
    }

    function numProperties() constant returns (uint setSize) {
        return _set.size();
    }
}


contract PropertySetTest is Test {

    bytes32 constant TEST_PROPERTY = 0x12345;
    bytes32 constant TEST_PROPERTY_2 = 0xABCDEF;
    bytes32 constant TEST_PROPERTY_3 = 0xC0FFEE;

    function testInsert() {
        var psdb = new PropertySetDb();

        psdb.addProperty(TEST_PROPERTY).assert("addProperty does not return true");
        psdb.hasProperty(TEST_PROPERTY).assert("hasProperty does not return true");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assert("propertyFromIndex exist is false");
        a.assertEqual(TEST_PROPERTY, "propertyFromIndex returns the wrong address");
        psdb.numProperties().assertEqual(1, "size is wrong");
    }

    function testRemoveProperty() {
        var psdb = new PropertySetDb();
        psdb.addProperty(TEST_PROPERTY);

        psdb.removeProperty(TEST_PROPERTY).assert("removeProperty does not return true");
        psdb.hasProperty(TEST_PROPERTY).assertFalse("hasProperty does not return false");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assertFalse("propertyFromIndex exist is true");
        a.assertZero("propertyFromIndex returns non-zero address");
        psdb.numProperties().assertZero("size is not zero");
    }

    function testAddTwoBProperties() {
        var psdb = new PropertySetDb();
        psdb.addProperty(TEST_PROPERTY);

        psdb.addProperty(TEST_PROPERTY_2).assert("addProperty does not return true for second element");
        psdb.hasProperty(TEST_PROPERTY).assert("hasProperty does not return true for first element");
        psdb.hasProperty(TEST_PROPERTY_2).assert("hasProperty does not return true for second element");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assert("propertyFromIndex exist is false for first element");
        a.assertEqual(TEST_PROPERTY, "propertyFromIndex returns the wrong address for first element");
        (a, e) = psdb.propertyFromIndex(1);
        e.assert("propertyFromIndex exist is false for second element");
        a.assertEqual(TEST_PROPERTY_2, "propertyFromIndex returns the wrong address for second element");

        psdb.numProperties().assertEqual(2, "size is not 2");
    }

    function testAddTwoPropertiesRemoveLast() {
        var psdb = new PropertySetDb();
        psdb.addProperty(TEST_PROPERTY);
        psdb.addProperty(TEST_PROPERTY_2);
        psdb.removeProperty(TEST_PROPERTY_2);

        psdb.hasProperty(TEST_PROPERTY).assert("hasProperty does not return true for first element");
        psdb.hasProperty(TEST_PROPERTY_2).assertFalse("hasProperty does not return false for second element");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assert("propertyFromIndex exist is false for first element");
        a.assertEqual(TEST_PROPERTY, "propertyFromIndex returns the wrong address for first element");
        (a, e) = psdb.propertyFromIndex(1);
        e.assertFalse("propertyFromIndex exist is true for second element");
        a.assertZero("propertyFromIndex returns the wrong address for second element");

        psdb.numProperties().assertEqual(1, "size is not 1");
    }

    function testAddTwoPropertiesRemoveFirst() {
        var psdb = new PropertySetDb();
        psdb.addProperty(TEST_PROPERTY);
        psdb.addProperty(TEST_PROPERTY_2);
        psdb.removeProperty(TEST_PROPERTY);

        psdb.hasProperty(TEST_PROPERTY).assertFalse("hasProperty does not return false for first element");
        psdb.hasProperty(TEST_PROPERTY_2).assert("hasProperty does not return true for second element");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assert("propertyFromIndex exist is false for first element");
        a.assertEqual(TEST_PROPERTY_2, "propertyFromIndex returns the wrong address for first element");
        (a, e) = psdb.propertyFromIndex(1);
        e.assertFalse("propertyFromIndex exist is true for second element");
        a.assertZero("propertyFromIndex returns the wrong address for second element");

        psdb.numProperties().assertEqual(1, "size is not 1");
    }

    function testAddThreePropertiesRemoveMiddle() {
        var psdb = new PropertySetDb();
        psdb.addProperty(TEST_PROPERTY);
        psdb.addProperty(TEST_PROPERTY_2);
        psdb.addProperty(TEST_PROPERTY_3);
        psdb.removeProperty(TEST_PROPERTY_2);

        psdb.hasProperty(TEST_PROPERTY).assert("hasProperty does not return true for first element");
        psdb.hasProperty(TEST_PROPERTY_2).assertFalse("hasProperty does not return false for second element");
        psdb.hasProperty(TEST_PROPERTY_3).assert("hasProperty does not return true for third element");

        var (a, e) = psdb.propertyFromIndex(0);
        e.assert("propertyFromIndex exist is false for first element");
        a.assertEqual(TEST_PROPERTY, "propertyFromIndex returns the wrong address for first element");

        (a, e) = psdb.propertyFromIndex(1);
        e.assert("propertyFromIndex exist is false for second element");
        a.assertEqual(TEST_PROPERTY_3, "propertyFromIndex returns the wrong address for second element");

        (a, e) = psdb.propertyFromIndex(2);
        e.assertFalse("propertyFromIndex exist is true for third element");
        a.assertZero("propertyFromIndex returns the wrong address for third element");
    }

}