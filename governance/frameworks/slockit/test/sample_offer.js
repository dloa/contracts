contract('SampleOffer', function(accounts) {
  it("should assert true", function(done) {
    var sample_offer = SampleOffer.at(SampleOffer.deployed_address);
    assert.isTrue(true);
    done();
  });
});
