contract('DAOTokenSaleProxyTransferer', function(accounts) {
  it("should assert true", function(done) {
    var d_a_o_token_sale_proxy_transferer = DAOTokenSaleProxyTransferer.at(DAOTokenSaleProxyTransferer.deployed_address);
    assert.isTrue(true);
    done();
  });
});
