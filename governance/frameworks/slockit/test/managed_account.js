contract('ManagedAccount', function(accounts) {
  it("should assert true", function(done) {
    var managed_account = ManagedAccount.at(ManagedAccount.deployed_address);
    assert.isTrue(true);
    done();
  });
});
