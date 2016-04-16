"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var ManagedAccount = (function (_Pudding) {
    _inherits(ManagedAccount, _Pudding);

    function ManagedAccount() {
      _classCallCheck(this, ManagedAccount);

      _get(Object.getPrototypeOf(ManagedAccount.prototype), "constructor", this).apply(this, arguments);
    }

    return ManagedAccount;
  })(Pudding);

  ;

  // Set up specific data for this class.
  ManagedAccount.abi = [{ "constant": false, "inputs": [{ "name": "_recipient", "type": "address" }, { "name": "_amount", "type": "uint256" }], "name": "payOut", "outputs": [{ "name": "", "type": "bool" }], "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": true, "inputs": [], "name": "accumulatedInput", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "inputs": [{ "name": "_owner", "type": "address" }], "type": "constructor" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "_recipient", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }], "name": "PayOut", "type": "event" }];
  ManagedAccount.binary = "606060405260405160208061014f83395060806040525160008054600160a060020a0319168217905550610118806100376000396000f3606060405236156100355760e060020a60003504630221038a81146100425780638da5cb5b14610074578063d2cc718f14610086575b61008f6001805434019055565b6100916004356024356000805433600160a060020a03908116911614158061006a5750600034115b156100ad57610002565b6100a3600054600160a060020a031681565b61009160015481565b005b60408051918252519081900360200190f35b6060908152602090f35b600160a060020a0383168260608381818185876185025a03f1925050501561011257604080518381529051600160a060020a038516917f9735b0cb909f3d21d5c16bbcccd272d85fa11446f6d679f6ecb170d2dabfecfc919081900360200190a25060015b9291505056";

  if ("" != "") {
    ManagedAccount.address = "";

    // Backward compatibility; Deprecated.
    ManagedAccount.deployed_address = "";
  }

  ManagedAccount.generated_with = "1.0.3";
  ManagedAccount.contract_name = "ManagedAccount";

  return ManagedAccount;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.ManagedAccount = factory;
}