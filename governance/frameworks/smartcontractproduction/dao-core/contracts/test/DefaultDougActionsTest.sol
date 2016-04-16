import "DougBase";

contract DefaultDougActionsTest is DaoTest {

    address constant TEST_ADDRESS = 0x12345;

    bytes32 constant TEST_BYTES32   = 1;
    bytes32 constant TEST_BYTES32_2 = 2;
    bytes32 constant TEST_BYTES32_3 = 3;

    function testAddActionsContract() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        var err = doug.addActionsContract(TEST_BYTES32, mc);
        err.assertNoError("addActionsContract returned error.");
        var cAddr = doug.actionsContractAddress(TEST_BYTES32);
        cAddr.assertEqual(mc, "actionsContractAddress returned the wrong address.");
        var (id, addr, errId) = doug.actionsContractFromIndex(0);
        id.assertEqual(TEST_BYTES32, "actionsContractAddress returned the wrong Id.");
        errId.assertNoError("actionsContractFromIndex returned error.");
        doug.actionsContractId(mc).assertEqual(TEST_BYTES32, "actionsContractId returned the wrong Id.");
        doug.numActionsContracts().assertEqual(1, "size of actions contracts map is not 1");
    }

    function testAddActionsContractFailNotRoot() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(false), false, false);
        var err = doug.addActionsContract(0, 0);
        err.assertErrorsEqual(ACCESS_DENIED, "addActionsContract did not return 'access denied' error");
    }

    function testAddActionsContractFailBadId() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.addActionsContract(0, TEST_ADDRESS);
        err.assertErrorsEqual(NULL_PARAM_NOT_ALLOWED, "addActionsContract did not return 'null parameter' error");
    }

    function testAddActionsContractFailBadAddress() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.addActionsContract(TEST_BYTES32, 0);
        err.assertErrorsEqual(NULL_PARAM_NOT_ALLOWED, "addActionsContract did not return 'null parameter' error");
    }

    // TODO
    // function testAddDatabaseContractFailContractNotDougEnabled() {}

    function testAddActionsContractOverwriteSuccess() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        doug.addActionsContract(TEST_BYTES32, mc);
        var mc2 = new MockContract();
        var err = doug.addActionsContract(TEST_BYTES32, mc2);
        err.assertNoError("addActionsContract returned error.");
        doug.actionsContractAddress(TEST_BYTES32).assertEqual(mc2, "Address not correct.");
        doug.actionsContractId(mc).assertZero("actionsContractId for first contract not zero");
    }

    function testAddAndRemoveActionsContract() {
        DefaultDoug doug = new DefaultDoug(new MockPermission(true), false, false);
        var mc = new MockContract();
        var err = doug.addActionsContract(TEST_BYTES32, mc);
        err.assertNoError("addActionsContract returned error.");
        err = doug.removeActionsContract(TEST_BYTES32);
        err.assertNoError("removeActionsContract returned error.");

        doug.actionsContractAddress(TEST_BYTES32).assertZero("actionsContractAddress returned non-zero address.");
        doug.actionsContractId(mc).assertZero("actionsContractId returned non-zero Id.");

        var (id, addr, errId) = doug.actionsContractFromIndex(0);
        id.assertZero("actionsContractFromIndex returned non-zero Id.");
        addr.assertZero("actionsContractFromIndex returned non-zero address.");
        errId.assertErrorsEqual(ARRAY_INDEX_OUT_OF_BOUNDS, "actionsContractFromIndex did not return 'array index out-of-bounds' error.");
        doug.numActionsContracts().assertZero("size of action contracts map is not zero");
    }

}
