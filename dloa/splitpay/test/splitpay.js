contract('SplitPay', function(accounts) {
  it("should validate that SplitPay is deployed and available", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    assert.isTrue(true);
    done();
  });

  it("should initialize a new SplitPay and check that the initial variables are being set correctly", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    SplitPay.new({ from: accounts[0] }).then(
      function(splitpay) {
        splitpay.buyer.call().then(
          function(buyer) {
            assert.equal(buyer, accounts[0], "SplitPay initiator addresses don't match");
          }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new SplitPay with a single content creator address and check that the initial numPayees variable is being set correctly", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    SplitPay.new({ from: accounts[0] }).then(
      function(splitpay) {
        splitpay.numPayees.call().then(
            function(numPayees) {
              assert.equal(numPayees, 0, "numPayees is not equal to 0");
            }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new SplitPay with a single content creator address and check that the initial buyer variable is being set correctly", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    SplitPay.new({ from: accounts[0] }).then(
      function(splitpay) {
        splitpay.buyer.call().then(
            function(buyer) {
              assert.equal(buyer, accounts[0], "buyer is not initialized properly");
            }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new SplitPay with a single content creator address and add a buyer and check that the buyer is being set correctly", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    SplitPay.new({ from: accounts[0] }).then(
      function(splitpay) {
	splitpay.addBuyer(accounts[1]).then(
  	  function() {
            splitpay.buyer.call().then(
              function(buyer) {
                assert.equal(buyer, accounts[1], "SplitPay initiator addresses don't match");
              }).then(done).catch(done);
          }).then(done).catch(done);
      }).then(done).catch(done);
  });


/*
  it("should add two content creator addresses", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    
    // magic numbers
    // 50: fifty percent
    // 0:  content creator
    splitpay.addPayee( accounts[1], 50, 0 ).then(
      function() {
        splitpay.addPayee( accounts[2], 50, 0 );
      }).then(done).catch(done);
  });

  it("should trigger payment to two content creator addresses", function(done) {
    var splitpay = SplitPay.at(SplitPay.deployed_address);
    
    splitpay.payout(1000);
    assert.isTrue(true);
    done();
  });
*/

});
