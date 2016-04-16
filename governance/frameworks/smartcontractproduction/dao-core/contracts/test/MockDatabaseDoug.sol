contract MockDatabaseDoug {

    bytes32 _id;

    function MockDatabaseDoug(bytes32 id) {
            _id = id;
    }

    function actionsContractId(address contractAddress) constant returns (bytes32 identifier) {
        return _id;
    }

}