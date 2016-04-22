// SingleTip
// Author:  Bill Gleim
// twitter: @billgleim

contract SingleTip {
	address public initiator;
	uint    public tip;
	address public recipient;

	function SingleTip( address _recipient, uint _tip ) {
		// record the initiator of the transaction
		initiator = msg.sender;

		// record the recipient of the transaction
		recipient = _recipient;

		// record the tip amount
		tip = _tip;
	}

	// returns true if transfer is successful, false in the case of any failure 
	function transfer() returns (bool) {
		// ensure sufficient funds are available
		if (this.balance > tip) {
			var sent = recipient.send( this.balance );
		} else {
  			return false;
		}

		if (sent) {
			return true;
		} else {
			return false;
		}
	}
}
    
