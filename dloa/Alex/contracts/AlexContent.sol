contract mortal {
	address owner;

	// executed at initialization and sets the owner of the contract
	function mortal() {
	    owner = msg.sender;
	}	

	// recover the funds on the contract
	function kill() {
	    if (msg.sender == owner)
	    	suicide(owner);
	}	
}

contract AlexContent is mortal {
	modifier onlyowner { if (msg.sender == owner) _ }

	address owner;
	string index;
	string name;
	uint price;
	mapping (address => uint) balances;
	mapping (address => bool) paid;

	function AlexContent() {
		owner = msg.sender;
	}

	function setIndex(string _index) onlyowner returns(bool success) {
		index = _index;
		return true;
	}

	function setName(string _name) onlyowner returns(bool success) {
		name = _name;
		return true;
	}

	function setPrice(uint _price) onlyowner returns(bool success) {
		price = _price;
		return true;
	}

	function getIndex() returns(string contentIndex) {
		return index;
	}

	function setName() returns(string contentName) {
		return name;
	}

	function setPrice() returns(uint contentPrice) {
		return price;
	}

	function purchase() returns(bool success) {
		if (balances[msg.sender] < price) return false;
		balances[msg.sender] -= price;
		balances[owner] += price;
		paid[msg.sender] = true;
		return true;
	}

	function contentPurchased() returns(bool purchased) {
		if (paid[msg.sender]) 
			return true;
		else
			return false;
	}

	function view() returns(bool success) {
		if (paid[msg.sender]) 
			return true;
	}
}
