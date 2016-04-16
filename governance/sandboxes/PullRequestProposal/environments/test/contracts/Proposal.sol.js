"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var Proposal = (function (_Pudding) {
    _inherits(Proposal, _Pudding);

    function Proposal() {
      _classCallCheck(this, Proposal);

      _get(Object.getPrototypeOf(Proposal.prototype), "constructor", this).apply(this, arguments);
    }

    return Proposal;
  })(Pudding);

  ;

  // Set up specific data for this class.
  Proposal.abi = [{ "constant": false, "inputs": [], "name": "acceptProposal", "outputs": [], "type": "function" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "acceptor", "type": "address" }, { "indexed": false, "name": "amount", "type": "uint256" }], "name": "ProposalAccepted", "type": "event" }];
  Proposal.binary = "606060405260648060106000396000f3606060405260e060020a6000350463af3b19e58114601a575b005b601873ffffffffffffffffffffffffffffffffffffffff33166060908152346080527f0447e15907813bfb966eab36935a68eeb6360426cc5d554898d37c9cb475cca690604090a156";

  if ("0x7ff0ae8a6097c4dd3a34b8a9e7c809aa0418ec1c" != "") {
    Proposal.address = "0x7ff0ae8a6097c4dd3a34b8a9e7c809aa0418ec1c";

    // Backward compatibility; Deprecated.
    Proposal.deployed_address = "0x7ff0ae8a6097c4dd3a34b8a9e7c809aa0418ec1c";
  }

  Proposal.generated_with = "1.0.3";
  Proposal.contract_name = "Proposal";

  return Proposal;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.Proposal = factory;
}