contract('DefaultPermissionTest', function(accounts) {
  it("should assert true", function(done) {
    var default_permission_test = DefaultPermissionTest.at(DefaultPermissionTest.deployed_address);
    assert.isTrue(true);
    done();
  });
});
