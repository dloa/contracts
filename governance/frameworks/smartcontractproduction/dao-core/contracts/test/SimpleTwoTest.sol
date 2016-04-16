import "./MockDatabaseDoug.sol";
import "./SimpleBase.sol";
import "dao-stl/src/assertions/DaoTest.sol";

contract SimpleTwoTest is DaoTest {

    uint constant TEST_DATA = 55;

    function testAddSuccess() {
        var mdd = new MockDatabaseDoug("simple");
        var dsdb = new DefaultSimpleDb();
        dsdb.setDougAddress(mdd);
        var st = new SimpleTwo(dsdb, this);
        st.addData(TEST_DATA).assertNoError("addData returned an error");
    }

    function testAddFailNotActions() {
        var mdd = new MockDatabaseDoug("");
        var dsdb = new DefaultSimpleDb();
        var st = new SimpleTwo(dsdb, this);
        dsdb.setDougAddress(mdd);
        st.addData(TEST_DATA).assertErrorsEqual(ACCESS_DENIED, "addData returned no 'access denied' error");
    }

    function testAddFailNotOwner() {
        new SimpleTwo(0, 0).addData(TEST_DATA)
            .assertErrorsEqual(ACCESS_DENIED, "addData returned no 'access denied' error");
    }

}