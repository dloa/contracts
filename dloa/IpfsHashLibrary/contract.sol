// Ipfs Hash Library contract
contract IpfsHashLibrary
{
	function setIpfsHash(bytes32 _key, uint256 _value) {
		ipfsHashStore[_key] = _value;
	}
	mapping (bytes32 => uint256) public ipfsHashStore;
}
