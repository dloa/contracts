contract('Proposal', function(accounts) {

  it("should trigger acceptance of proposal", function(error, result) {

	var proposal = Proposal.deployed();

	var event = proposal.ProposalAccepted();

	// watch for events to be emitted
	event.watch(function(error, result) {

		if (!error) {
			var msg = "Proposal Accepted: " + hex2a(result.args.msg) + " from " + result.args.sender + " (block:" + result.blockNumber + ")";
			console.log(msg); 	
		} else {
			console.log(error);
		}
	});

	var event2 = proposal.ProposalAccepted(function(error, result) {
		if (!error) {
			var msg = "Proposal Accepted: " + hex2a(result.args.msg) + " from " + result.args.sender + " (block:" + result.blockNumber + ")";
			console.log(msg); 	
		} else {
			console.log(error);
		}
	});

	console.log("calling proposal::ProposalAccepted");

	var event3 = proposal.acceptProposal.sendTransaction().then(function(originator) {
		var msg = "Proposal Accepted: " + originator;
		console.log(msg); 	
  	}).then(done).catch(done);
		
  });

  it("should trigger acceptance of proposal from the first account", function(error, result) {

	var proposal = Proposal.deployed();

	console.log("calling proposal::ProposalAccepted");

	var event = proposal.ProposalAccepted( {},function(error, result) {

		console.log("called proposal::ProposalAccepted");

		if (!error) {
			var msg = "Proposal Accepted: " + hex2a(result.args.msg) + " from " + result.args.sender + " (block:" + result.blockNumber + ")";
			console.log(msg); 	
		} else {
			console.log(error);
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
