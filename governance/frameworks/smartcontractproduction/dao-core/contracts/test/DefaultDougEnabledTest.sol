import "./DougBase.sol";

contract DefaultDougEnabledTest is DaoTest {

    address constant TEST_ADDRESS = 0x12345;
    address constant TEST_ADDRESS_2 = 0x23456;

    function testSetDougSuccess() {
        var dds = new DefaultDougSettable(0);
        var ret = dds.setDougAddress(TEST_ADDRESS);
        ret.assertEqual(TEST_ADDRESS, "setDougAddress returned false");
        dds.dougAddress().assertEqual(TEST_ADDRESS, "dougAddress returns wrong address.");
    }

    function testSetDougFailNullArgument() {
        var dds = new DefaultDougSettable(0);
        var ret = dds.setDougAddress(0);
        ret.assertZero("setDougAddress returned wrong value");
    }

    function testSetDougFailAlreadySet() {
        var dds = new DefaultDougSettable(TEST_ADDRESS);
        var ret = dds.setDougAddress(TEST_ADDRESS_2);
        ret.assertEqual(TEST_ADDRESS, "setDougAddress returned wrong value");
    }

    function testSetDougSuccessDougIsCaller() {
        var dds = new DefaultDougSettable(address(this));
        var ret = dds.setDougAddress(TEST_ADDRESS);
        ret.assertEqual(TEST_ADDRESS, "setDougAddress returned false");
        dds.dougAddress().assertEqual(TEST_ADDRESS, "dougAddress returns wrong address.");
    }

}