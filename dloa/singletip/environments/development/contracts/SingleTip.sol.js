"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var SingleTip = (function (_Pudding) {
    _inherits(SingleTip, _Pudding);

    function SingleTip() {
      _classCallCheck(this, SingleTip);

      _get(Object.getPrototypeOf(SingleTip.prototype), "constructor", this).apply(this, arguments);
    }

    return SingleTip;
  })(Pudding);

  ;

  // Set up specific data for this class.
  SingleTip.abi = [{ "constant": true, "inputs": [], "name": "tip", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "initiator", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": true, "inputs": [], "name": "recipient", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": false, "inputs": [], "name": "transfer", "outputs": [{ "name": "", "type": "bool" }], "type": "function" }, { "inputs": [{ "name": "_recipient", "type": "address" }, { "name": "_tip", "type": "uint256" }], "type": "constructor" }];
  SingleTip.binary = "606060408181528061011b833960a09052516080516000805433600160a060020a03199182161782556002805490911690931790925560015560d590819061004690396000f3606060405260e060020a60003504632755cd2d811460385780635c39fcc114604057806366d003ac1460515780638a4068dd146062575b005b60b060015481565b60c2600054600160a060020a031681565b60c2600254600160a060020a031681565b60b06000600060016000505430600160a060020a031631111560ac57600254600160a060020a03908116908290301631606082818181858883f1945050505050801560ac57600191505b5090565b60408051918252519081900360200190f35b600160a060020a03166060908152602090f3";

  if ("0x22f474da38b97dd6d3f02172f6809f32b91b051a" != "") {
    SingleTip.address = "0x22f474da38b97dd6d3f02172f6809f32b91b051a";

    // Backward compatibility; Deprecated.
    SingleTip.deployed_address = "0x22f474da38b97dd6d3f02172f6809f32b91b051a";
  }

  SingleTip.generated_with = "1.0.3";
  SingleTip.contract_name = "SingleTip";

  return SingleTip;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.SingleTip = factory;
}