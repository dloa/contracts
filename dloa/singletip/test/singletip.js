contract("SingleTip", function(accounts) {
	var singletip = null;

	it("checks contract availability", function(done) {
		SingleTip.at(SingleTip.deployed_address);
		assert.isTrue(true);
		done();
	});
	
	it("checks constructor and initial internal SingleTip contract state", function(done) {
		var tip = null;
		var recipient = null;

		SingleTip.at(SingleTip.deployed_address);

		SingleTip.new(accounts[1], 10000).then(
			function(sTip) {
				singletip = sTip;
				return singletip.tip.call();
			}
		).then(
			function(tipValue) {
				tip = tipValue;
				return singletip.recipient.call();
			}
		).then(
			function(recipientAddress) {
				recipient = recipientAddress;
				return singletip.initiator.call();
			}
		).then(
			function(initiator) {
				assert.equal(tip.toNumber(), 10000, "tip values do not match");
				assert.equal(recipient, accounts[1], "recipient addresses do not match");
				assert.equal(initiator, accounts[0], "initiator addresses do not match");
			}
		).then(done).catch(done);
	});

	it("validates initial balances", function(done) {
		var initialPayerBalance;
		var initialPayeeBalance;
		var initialContractBalance;

		new Promise(
			function(resolve, error) {
				return web3.eth.getBalance(accounts[1], function(err, hash) {
					if (err) {
						return error(err);	
					} else {
						return resolve(hash);
					}
				});
			}
		).then(
			function(recipientPreTx) {
				initialPayeeBalance = recipientPreTx;

				console.log("Recipient balance before Tip is " + initialPayeeBalance);

				return new Promise(function(resolve, error) {
					return new web3.eth.getBalance(accounts[0], function(err, hash) {
						if (err) {
							return error(err);
						} else {
							return resolve(hash);
						}
					});
				});
			}
		).then(
			function(senderPreTx) {
				initialPayerBalance = senderPreTx;

				console.log("Tipper balance before Tip is " + initialPayerBalance);

				return new Promise(function(resolve, error) {
					return new web3.eth.getBalance(singletip.address, function(err, hash) {
						if (err) {
							return error(err);
						} else {
							return resolve(hash);
						}
					});
				});
			}
		).then(
			function(contractPreTx) {
				initialContractBalance = contractPreTx;

				console.log("Contract balance before Tip is " + initialContractBalance);
			}
		).then(done).catch(done);
	});

	it("validates address balance transfers", function(done) {
		var finalPayerBalance;
		var finalPayeeBalance;
		var finalContractBalance;
		
		new Promise(
			function(resolve, error) {
				return web3.eth.sendTransaction( { to: singletip.address, value: "1000000", from: accounts[0] }, function(err, success) {
					if (err) {
						return error(err);	
					} else {
						return resolve(success);
					}
				});
			}
		// contract should now be funded
		).then(
			function(contractFundingResult) {
				console.log("Contract funding result is " + contractFundingResult);

				return singletip.transfer();
			}
		// transfer should now be completed
		).then(
			function(transferResult) {
				console.log("Transfer result: " + transferResult);

				//assert.equal(transferResult, true, "transfer failed!");

				return new Promise(function(resolve, error) {
					return new web3.eth.getBalance(accounts[1], function(err, hash) {
						if (err) {
							return error(err);
						} else {
							return resolve(hash);
						}
					});
				});
			}
		).then(
			function(recipientPostTx) {
				finalPayeeBalance = recipientPostTx;

				console.log("Recipient balance after Tip is " + finalPayeeBalance);

				return new Promise(function(resolve, error) {
					return new web3.eth.getBalance(accounts[0], function(err, hash) {
						if (err) {
							return error(err);
						} else {
							return resolve(hash);
						}
					});
				});
			}
		).then(
			function(senderPostTx) {
				finalPayerBalance = senderPostTx;

				console.log("Tipper balance after Tip is " + finalPayerBalance);

				return new Promise(function(resolve, error) {
					return new web3.eth.getBalance(singletip.address, function(err, hash) {
						if (err) {
							return error(err);
						} else {
							return resolve(hash);
						}
					});
				});
			}
		).then(
			function(contractPostTx) {
				finalContractBalance = contractPostTx;

				console.log("Contract balance after Tip is " + finalContractBalance);
			}
		).then(done).catch(done);
	});
});

