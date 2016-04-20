contract('Token', function(accounts) {
  it("should assert true", function(done) {
    var token = Token.at(Token.deployed_address);
    assert.isTrue(true);
    done();
  });
});
