contract('SoloPay', function(accounts) {
  it("should validate that SoloPay is deployed and available", function(done) {
    var solopay = SoloPay.at(SoloPay.deployed_address);
    assert.isTrue(true);
    done();
  });

  it("should initialize a new SoloPay and check that the initial variables are being set correctly", function(done) {
    var solopay = SoloPay.at(SoloPay.deployed_address);
    SoloPay.new(accounts[1], { from: accounts[0], value: 1000 }).then(
      function(solopay) {
        solopay.payer.call().then(
          function(payer) {
            assert.equal(payer, accounts[0], "SoloPay payer addresses don't match");
          }).then(done).catch(done);
      }).then(
      function() {
        solopay.payee.call().then(
          function(payer) {
            assert.equal(payee, accounts[1], "SoloPay payee addresses don't match");
          }).then(done).catch(done);
      }).then(
      function() {
        solopay.payerBeginningBalance.call().then(
          function(payerBeginningBalance) {
            assert.equal(payerBeginningBalance, 0, "payer beginning address balance does not equal zero");
          }).then(done).catch(done);
      }).then(
      function() {
        solopay.payeeBeginningBalance.call().then(
          function(payeeBeginningBalance) {
            assert.equal(payeeBeginningBalance, 0, "payee beginning address balance does not equal zero");
          }).then(done).catch(done);
      }).then(
      function() {
        solopay.payerFinalBalance.call().then(
          function(payerFinalBalance) {
            assert.equal(payerFinalBalance, 0, "payer final address balance does not equal zero");
          }).then(done).catch(done);
      }).then(
      function() {
        solopay.payeeFinalBalance.call().then(
          function(payeeFinalBalance) {
            assert.equal(payeeFinalBalance, 0, "payee final address balance does not equal zero");
          }).then(done).catch(done);
      }).then(done);
   });
});
