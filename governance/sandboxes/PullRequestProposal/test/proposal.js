contract('Proposal', function(accounts) {

  it("should trigger acceptance of proposal from the first account", function(error, result) {

	var proposal = Proposal.deployed();

	var event = proposal.ProposalAccepted( {},function(error, result) {
		if (!error) {
			var msg = "Proposal Accepted: " + hex2a(result.args.msg) + " from " + result.args.sender + " (block:" + result.blockNumber + ")";
			Console.log(msg); 	
		} else {
			Console.log(error);
		}
  	}).then(done).catch(done);
  });

  it("should trigger acceptance of proposal", function(error, result) {

	var proposal = Proposal.deployed();

	var event = proposal.acceptProposal.call().then(function(originator) {
		var msg = "Proposal Accepted: " + originator;
		Console.log(msg); 	
  	}).then(done).catch(done);
  });

});
