import "dao-stl/src/assertions/DaoTest.sol";
import "dao-core/src/DefaultPermission.sol";

// Timestamp tests must be done on "real" eth node or they'll always be 0.
contract DefaultPermissionTest is DaoTest {

    address constant TEST_ADDRESS = 0xFFFFFF;

    function testCreatePermission() {
        var p = new DefaultPermission(this);
        p.root().assertEqual(this, "permissions root address is not the creator.");
    }

    function testSetRootSuccess() {
        var p = new DefaultPermission(this);
        var error = p.setRoot(TEST_ADDRESS);
        error.assertNoError("Set root error");
        p.root().assertEqual(TEST_ADDRESS, "permissions root address is not correct.");
    }

    function testSetRootFail() {
        var p = new DefaultPermission(TEST_ADDRESS);
        var error = p.setRoot(this);
        error.assertErrorsEqual(ACCESS_DENIED, "Access not denied.");
        p.root().assertEqual(TEST_ADDRESS, "permissions root address is not the creator.");
    }

    function testRootData() {
        var (addr, time) = (new DefaultPermission(this)).rootData();
        addr.assertEqual(this, "permissions root address is not correct.");
        time.assertEqual(block.timestamp, "timestamp not correct");
    }


    function testRootHasPermission() {
        var p = new DefaultPermission(this);
        p.hasPermission(this).assert("Root does not have permission.");
    }

    function testAddOwnerSuccess() {
        var p = new DefaultPermission(this);
        var aErr = p.addOwner(TEST_ADDRESS);
        aErr.assertNoError("addOwner returned error");
        var (oTime, oErr) = p.ownerTimestamp(TEST_ADDRESS);
        oTime.assertEqual(block.timestamp, "owner timestamp not correct.");
        oErr.assertNoError("ownerTimestamp returned error");
        var (,iErr) = p.ownerFromIndex(0);
        iErr.assertNoError("ownerFromIndex returned error");
        p.hasPermission(TEST_ADDRESS).assert("owner does not have permission.");
    }

    function testAddOwnerFailBadAddress() {
        var p = new DefaultPermission(this);
        var aErr = p.addOwner(0);
        aErr.assertErrorsEqual(NULL_PARAM_NOT_ALLOWED, "addOwner did not return 'null param' error.");
        var (oTime, oErr) = p.ownerTimestamp(0);
        oTime.assertZero("owner timestamp not zero.");
        oErr.assertErrorsEqual(RESOURCE_NOT_FOUND, "ownerTimestamp did not return 'not found' error.");
        var (,iErr) = p.ownerFromIndex(0);
        iErr.assertErrorsEqual(ARRAY_INDEX_OUT_OF_BOUNDS, "ownerTimestamp did not return 'array index out-of-bounds' error.");
        p.hasPermission(0).assertFalse("null address is owner");
    }

    function testAddOwnerFailIsRoot() {
        var p = new DefaultPermission(this);
        var aErr = p.addOwner(this);
        aErr.assertErrorsEqual(INVALID_PARAM_VALUE, "addOwner did not return 'invalid param' error.");
        var (oTime, oErr) = p.ownerTimestamp(this);
        oTime.assertZero("owner timestamp not zero.");
        oErr.assertErrorsEqual(RESOURCE_NOT_FOUND, "ownerTimestamp did not return 'not found' error.");
        var (,iErr) = p.ownerFromIndex(0);
        iErr.assertErrorsEqual(ARRAY_INDEX_OUT_OF_BOUNDS, "ownerTimestamp did not return 'array index out-of-bounds' error.");
    }

    function testAddOwnerFailNoPerm() {
        var p = new DefaultPermission(TEST_ADDRESS);
        var aErr = p.addOwner(this);
        aErr.assertErrorsEqual(ACCESS_DENIED, "addOwner did not return 'access denied' error.");
        var (oTime, oErr) = p.ownerTimestamp(this);
        oTime.assertZero("owner timestamp not zero.");
        oErr.assertErrorsEqual(RESOURCE_NOT_FOUND, "ownerTimestamp did not return 'not found' error.");
        var (,iErr) = p.ownerFromIndex(0);
        iErr.assertErrorsEqual(ARRAY_INDEX_OUT_OF_BOUNDS, "ownerTimestamp did not return 'array index out-of-bounds' error.");
    }

    function testAddOwnerFailAlreadyExists() {
        var p = new DefaultPermission(this);
        var aErr = p.addOwner(TEST_ADDRESS);
        aErr = p.addOwner(TEST_ADDRESS);
        aErr.assertErrorsEqual(RESOURCE_ALREADY_EXISTS, "addOwner did not return 'resource exists' error.");
        var (oTime, oErr) = p.ownerTimestamp(TEST_ADDRESS);
        oTime.assertNotZero("owner timestamp is zero.");
        oErr.assertNoError("ownerTimestamp returned errror");
        var (,iErr) = p.ownerFromIndex(0);
        iErr.assertNoError("ownerFromIndex(0) returned error");
        p.hasPermission(TEST_ADDRESS).assert("owner does not have permission");
    }

}