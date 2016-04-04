"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var SoloPay = (function (_Pudding) {
    _inherits(SoloPay, _Pudding);

    function SoloPay() {
      _classCallCheck(this, SoloPay);

      _get(Object.getPrototypeOf(SoloPay.prototype), "constructor", this).apply(this, arguments);
    }

    return SoloPay;
  })(Pudding);

  ;

  // Set up specific data for this class.
  SoloPay.abi = [{ "constant": true, "inputs": [], "name": "payer", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": true, "inputs": [], "name": "payerFinalBalance", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "payeeBeginningBalance", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "payerBeginningBalance", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "payee", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": true, "inputs": [], "name": "payeeFinalBalance", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "inputs": [{ "name": "_payeeAddress", "type": "address" }], "type": "constructor" }];
  SoloPay.binary = "606060405260405160208061013b83395060806040525160008054600160a060020a0319908116331780835560018054909216841791829055346002819055600160a060020a0391821631600355911680316004559190608082818181858883f150509054600160a060020a0390811631600555600154163160065550505060b08061008b6000396000f360606040523615604f5760e060020a6000350463123119cd8114605157806313f307ed14606257806353641aa914606a57806361e12856146072578063ae90b21314607a578063b08de6cb14608b575b005b6093600054600160a060020a031681565b60a660055481565b60a660045481565b60a660035481565b6093600154600160a060020a031681565b60a660065481565b600160a060020a03166060908152602090f35b6060908152602090f3";

  if ("0x437d82e50bba0878a37e08628a74efd81b6f067f" != "") {
    SoloPay.address = "0x437d82e50bba0878a37e08628a74efd81b6f067f";

    // Backward compatibility; Deprecated.
    SoloPay.deployed_address = "0x437d82e50bba0878a37e08628a74efd81b6f067f";
  }

  SoloPay.generated_with = "1.0.3";
  SoloPay.contract_name = "SoloPay";

  return SoloPay;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.SoloPay = factory;
}