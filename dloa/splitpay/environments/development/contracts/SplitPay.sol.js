"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var SplitPay = (function (_Pudding) {
    _inherits(SplitPay, _Pudding);

    function SplitPay() {
      _classCallCheck(this, SplitPay);

      _get(Object.getPrototypeOf(SplitPay.prototype), "constructor", this).apply(this, arguments);
    }

    return SplitPay;
  })(Pudding);

  ;

  // Set up specific data for this class.
  SplitPay.abi = [{ "constant": true, "inputs": [], "name": "numPayees", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "_payeeAddress", "type": "address" }, { "name": "_payeePercentage", "type": "uint256" }, { "name": "_payeeType", "type": "uint256" }], "name": "addPayee", "outputs": [], "type": "function" }, { "constant": true, "inputs": [], "name": "buyer", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "_buyerAddress", "type": "address" }], "name": "addBuyer", "outputs": [], "type": "function" }, { "constant": false, "inputs": [{ "name": "_desiredPayoutAmount", "type": "uint256" }], "name": "payout", "outputs": [], "type": "function" }, { "inputs": [], "type": "constructor" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "from", "type": "address" }, { "indexed": true, "name": "lid", "type": "uint256" }, { "indexed": false, "name": "_value", "type": "uint256" }], "name": "onPayout", "type": "event" }];
  SplitPay.binary = "6060604052600060015560028054600160a060020a0319163317905561019f806100296000396000f3606060405260e060020a6000350463249200bf81146100475780632a11f719146100505780637150d8ae146100b7578063bbf89803146100c9578063e1152343146100ef575b005b61012b60015481565b60c060409081526004356060819052602435608081905260443560a0819052600180546000908152602081905294909420805473ffffffffffffffffffffffffffffffffffffffff1916909317835582840191909155600290910155805481019055610045565b61012b600254600160a060020a031681565b6002805473ffffffffffffffffffffffffffffffffffffffff1916600435179055610045565b610045600435600080805b60015482101561013557818152602081905260408120600101546064908502049290920191600191909101906100fa565b6060908152602090f35b83831161018d575b600154811015610199576000818152602081905260408082208054600191909101549151600160a060020a0391909116929160643491909102049082818181858883f1505050505060010161013d565b33600160a060020a0316ff5b5050505056";

  if ("0x88288a4f1076e144c7e5fb33271d5d72dffe1ef2" != "") {
    SplitPay.address = "0x88288a4f1076e144c7e5fb33271d5d72dffe1ef2";

    // Backward compatibility; Deprecated.
    SplitPay.deployed_address = "0x88288a4f1076e144c7e5fb33271d5d72dffe1ef2";
  }

  SplitPay.generated_with = "1.0.3";
  SplitPay.contract_name = "SplitPay";

  return SplitPay;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.SplitPay = factory;
}