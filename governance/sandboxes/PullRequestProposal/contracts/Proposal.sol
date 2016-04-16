contract Proposal {

	event ProposalAccepted(address acceptor, uint amount);

	function acceptProposal() {
		ProposalAccepted(msg.sender, msg.value);
	}

}
