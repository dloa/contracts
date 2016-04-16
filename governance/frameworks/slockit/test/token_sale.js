contract('TokenSale', function(accounts) {
  it("should assert true", function(done) {
    var token_sale = TokenSale.at(TokenSale.deployed_address);
    assert.isTrue(true);
    done();
  });
});
