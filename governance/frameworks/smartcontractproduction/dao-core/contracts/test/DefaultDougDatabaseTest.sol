import "./DougBase.sol";

contract DefaultDougDatabaseTest is DaoTest {

    address constant TEST_ADDRESS = 0x12345;

    bytes32 constant TEST_BYTES32   = 1;
    bytes32 constant TEST_BYTES32_2 = 2;
    bytes32 constant TEST_BYTES32_3 = 3;

    function testAddDatabaseContract() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        var err = doug.addDatabaseContract(TEST_BYTES32, mc);
        err.assertNoError("addDatabaseContract returned error.");
        var cAddr = doug.databaseContractAddress(TEST_BYTES32);
        cAddr.assertEqual(mc, "databaseContractAddress returned the wrong address.");
        var (id, addr, errId) = doug.databaseContractFromIndex(0);
        id.assertEqual(TEST_BYTES32, "databaseContractAddress returned the wrong Id.");
        errId.assertNoError("databaseContractFromIndex returned error.");
        doug.databaseContractId(mc).assertEqual(TEST_BYTES32, "databaseContractId returned the wrong Id.");
        doug.numDatabaseContracts().assertEqual(1, "size of database contracts map is not 1");
    }

    function testAddDatabaseContractFailNotRoot() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(false), false, false);
        var err = doug.addDatabaseContract(0, 0);
        err.assertErrorsEqual(ACCESS_DENIED, "addDatabaseContract did not return 'access denied' error");
    }

    function testAddDatabaseContractFailBadId() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.addDatabaseContract(0, TEST_ADDRESS);
        err.assertErrorsEqual(NULL_PARAM_NOT_ALLOWED, "addDatabaseContract did not return 'null parameter' error");
    }

    function testAddDatabaseContractFailBadAddress() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.addDatabaseContract(TEST_BYTES32, 0);
        err.assertErrorsEqual(NULL_PARAM_NOT_ALLOWED, "addDatabaseContract did not return 'null parameter' error");
    }

    // TODO
    // function testAddDatabaseContractFailContractNotDougEnabled() {}

    function testAddDatabaseContractOverwriteFail() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        doug.addDatabaseContract(TEST_BYTES32, mc);
        var mc2 = new MockContract();
        var err = doug.addDatabaseContract(TEST_BYTES32, mc2);
        doug.databaseContractAddress(TEST_BYTES32).assertEqual(mc2, "Address not correct.");
        doug.databaseContractId(mc).assertZero("databaseContractId for first contract not zero");
    }

    function testAddAndRemoveDatabaseContract() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        var err = doug.addDatabaseContract(TEST_BYTES32, mc);
        err.assertNoError("addDatabaseContract returned error.");
        err = doug.removeDatabaseContract(TEST_BYTES32);
        err.assertNoError("removeDatabaseContract returned error.");

        doug.databaseContractAddress(TEST_BYTES32).assertZero("databaseContractAddress returned non-zero address.");
        doug.databaseContractId(mc).assertZero("databaseContractId returned non-zero Id.");

        var (id, addr, errId) = doug.databaseContractFromIndex(0);
        id.assertZero("databaseContractFromIndex returned non-zero Id.");
        addr.assertZero("databaseContractFromIndex returned non-zero address.");
        errId.assertErrorsEqual(ARRAY_INDEX_OUT_OF_BOUNDS, "databaseContractFromIndex did not return 'array index out-of-bounds' error.");
        doug.numDatabaseContracts().assertZero("size of action contracts map is not zero");
    }

}