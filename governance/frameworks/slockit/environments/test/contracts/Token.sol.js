"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var Token = (function (_Pudding) {
    _inherits(Token, _Pudding);

    function Token() {
      _classCallCheck(this, Token);

      _get(Object.getPrototypeOf(Token.prototype), "constructor", this).apply(this, arguments);
    }

    return Token;
  })(Pudding);

  ;

  // Set up specific data for this class.
  Token.abi = [{ "constant": false, "inputs": [{ "name": "_spender", "type": "address" }, { "name": "_amount", "type": "uint256" }], "name": "approve", "outputs": [{ "name": "success", "type": "bool" }], "type": "function" }, { "constant": true, "inputs": [], "name": "totalSupply", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "_from", "type": "address" }, { "name": "_to", "type": "address" }, { "name": "_amount", "type": "uint256" }], "name": "transferFrom", "outputs": [{ "name": "success", "type": "bool" }], "type": "function" }, { "constant": true, "inputs": [{ "name": "_owner", "type": "address" }], "name": "balanceOf", "outputs": [{ "name": "balance", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "_to", "type": "address" }, { "name": "_amount", "type": "uint256" }], "name": "transfer", "outputs": [{ "name": "success", "type": "bool" }], "type": "function" }, { "constant": true, "inputs": [{ "name": "_owner", "type": "address" }, { "name": "_spender", "type": "address" }], "name": "allowance", "outputs": [{ "name": "remaining", "type": "uint256" }], "type": "function" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "_from", "type": "address" }, { "indexed": true, "name": "_to", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }], "name": "Transfer", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "_owner", "type": "address" }, { "indexed": true, "name": "_spender", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }], "name": "Approval", "type": "event" }];
  Token.binary = "60606040526102b8806100126000396000f3606060405236156100565760e060020a6000350463095ea7b3811461005857806318160ddd146100c357806323b872dd146100cc57806370a08231146100e8578063a9059cbb1461010e578063dd62ed3e14610127575b005b61010460043560243533600160a060020a03908116600081815260016020908152604080832094871680845294825282208590556060858152919392917f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259190a35060015b92915050565b61010460025481565b610104600435602435604435600060003411156101e657610002565b600160a060020a03600435166000908152602081905260409020545b6060908152602090f35b6101046004356024356000600034111561015b57610002565b610104600435602435600160a060020a038083166000908152600160209081526040808320938516835292905220546100bd565b33600160a060020a03168152602081905260408120548290108015906101815750600082115b156101e157604080822080548490039055600160a060020a03808516808452918320805485019055606084815233909116907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef90602090a35060016100bd565b6100bd565b600160a060020a03841681526020819052604081205482901080159061022a575060016020908152604080832033600160a060020a03168452909152812054829010155b80156102365750600082115b156102b1576040808220600160a060020a0380861680855260208581528486208054880190558289168087528454889003909455600181528486203390931686529182529284208054869003905560608581527fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9190a35060015b939250505056";

  if ("" != "") {
    Token.address = "";

    // Backward compatibility; Deprecated.
    Token.deployed_address = "";
  }

  Token.generated_with = "1.0.3";
  Token.contract_name = "Token";

  return Token;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.Token = factory;
}