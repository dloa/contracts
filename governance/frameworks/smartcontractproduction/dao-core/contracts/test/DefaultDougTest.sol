import "./DougBase.sol";

contract DefaultDougTest is DaoTest {

    function testPermission() {
        var pm = new MockPermission(true);
        var doug = new DefaultDoug(pm, false, false);
        doug.permissionAddress().assertEqual(pm, "permission address not correct");
    }

    function testBaseOptionsFalse() {
        var pm = new MockPermission(true);
        var doug = new DefaultDoug(pm, false, false);
        doug.destroyRemovedActions().assertFalse("destroy removed actions is true");
        doug.destroyRemovedDatabases().assertFalse("destroy removed databases is true");
    }

    function testBaseOptionsTrue() {
        var pm = new MockPermission(true);
        var doug = new DefaultDoug(pm, true, true);
        doug.destroyRemovedActions().assert("destroy removed actions is false");
        doug.destroyRemovedDatabases().assert("destroy removed databases is false");
    }

    function testSetDestroyRemovedActions() {
        var doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.setDestroyRemovedActions(true);
        err.assertNoError("setDestroyRemovedActions returned error");
        doug.destroyRemovedActions().assert("destroy removed actions is false");
    }

    function testSetDestroyRemovedActionsFailAccessDenied() {
        var doug = new DefaultDoug(new MockPermission(false), false, false);
        var err = doug.setDestroyRemovedActions(true);
        err.assertErrorsEqual(ACCESS_DENIED, "setDestroyRemovedActions did not return 'access denied' error.");
        doug.destroyRemovedActions().assertFalse("destroy removed actions is true");
    }

    function testSetDestroyRemovedDatabases() {
        var doug = new DefaultDoug(new MockPermission(true), false, false);
        var err = doug.setDestroyRemovedDatabases(true);
        err.assertNoError("setDestroyRemovedDatabases returned error");
        doug.destroyRemovedDatabases().assert("destroy removed databases is false");
    }

    function testSetDestroyRemovedDatabasesFailAccessDenied() {
        var doug = new DefaultDoug(new MockPermission(false), false, false);
        var err = doug.setDestroyRemovedDatabases(true);
        err.assertErrorsEqual(ACCESS_DENIED, "setDestroyRemovedActions did not return 'access denied' error.");
        doug.destroyRemovedDatabases().assertFalse("destroy removed databases is true");
    }

}