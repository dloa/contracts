contract Proposal {

	event ProposalAccepted(address _from);

	function acceptProposal() {
		ProposalAccepted(msg.sender);
	}

}
