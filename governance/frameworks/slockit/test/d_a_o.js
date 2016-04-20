contract('DAO_Creator', function(accounts) {
  it("should validate that DAO Creator utility contract is deployed and available", function(done) {
    var daoCreator = DAO_Creator.at(DAO_Creator.deployed_address);
    assert.isTrue(true);
    done();
  });
});

contract('DAO', function(accounts) {
  it("should validate that DAO contract is deployed and available", function(done) {
    var dao = DAO.at(DAO.deployed_address);
    assert.isTrue(true);
    done();
  });

  /*
  contract DAO_Creator {
    function createDAO(
        address _curator,
        uint _proposalDeposit,
        uint _minValue,
        uint _closingTime
    ) returns (DAO _newDAO) {

        return new DAO(
            _curator,
            DAO_Creator(this),
            _proposalDeposit,
            _minValue,
            _closingTime,
            msg.sender
        );
    }
  }
  
closting time 1461974400
Is equivalent to:
04/30/2016 @ 12:00am (UTC)
  */

  it("should initialize a new DAO via DAOCreator and check that the creator variable is being set correctly", function(done) {
    var daoCreator = DAO_Creator.at(DAO_Creator.deployed_address);
    daoCreator.createDao( accounts[0], //curator
                          20,          // proposalDeposit: default value
                          10000000,    // minimum value
                          1461974400  // closing time
                        ).then(
      function(dao) {
        dao.daoCreator.call().then(
          function(creator) {
            assert.equal(creator, accounts[0], "Dao creator addresses don't match");
          }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new DAO and check that the creator variable is being set correctly", function(done) {
    var dao = DAO.at(DAO.deployed_address);
    dao.new({ from: accounts[0] }).then(
      function(dao) {
        dao.daoCreator.call().then(
          function(creator) {
            assert.equal(creator, accounts[0], "Dao creator addresses don't match");
          }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new DAO and check that the initial variables are being set correctly", function(done) {
    var dao = DAO.at(DAO.deployed_address);
    dao.new({ from: accounts[0] }).then(
      function(dao) {
        dao.proposalDeposit.call().then(
          function(proposal_deposit) {
            assert.equal(proposal_deposit, 0, "ProposalDeposit is not equal to zero at initialization");
          }).then(done).catch(done);
        dao.rewardAccount.call().then(
          function(reward_account) {
            assert.equal(reward_account, 0, "RewardAccount is not equal to zero at initialization");
          }).then(done).catch(done);
        dao.totalRewardToken.call().then(
          function(total_reward_token) {
            assert.equal(total_reward_token, 0, "TotalRewardToken is not equal to zero at initialization");
          }).then(done).catch(done);
        dao.rewards.call().then(
          function(reward) {
            assert.equal(reward, 0, "Rewards is not equal to zero at initialization");
          }).then(done).catch(done);
      }).catch(done);
  });

  it("should initialize a new DAO and add an Allowed Address and check that the allowed address is being set correctly", function(done) {
    var dao = DAO.at(DAO.deployed_address);
    dao.new({ from: accounts[0] }).then(
      function(dao) {
	dao.addAllowedAddress(accounts[1]).then(
  	  function(success) {
  	    assert.equal(success, true, "addAllowedAddress( ) does not return true")
            dao.allowedRecipients.call().then(
              function(allowed_recipients) {
                assert.equal(allowed_recipients[0], accounts[1], "Allowed Recipients addresses don't match");
              }).then(done).catch(done);
          }).then(done).catch(done);
      }).then(done).catch(done);
  });
});
