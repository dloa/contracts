"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var SampleOffer = (function (_Pudding) {
    _inherits(SampleOffer, _Pudding);

    function SampleOffer() {
      _classCallCheck(this, SampleOffer);

      _get(Object.getPrototypeOf(SampleOffer.prototype), "constructor", this).apply(this, arguments);
    }

    return SampleOffer;
  })(Pudding);

  ;

  // Set up specific data for this class.
  SampleOffer.abi = [{ "constant": true, "inputs": [], "name": "promiseValid", "outputs": [{ "name": "", "type": "bool" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "_rewardDivisor", "type": "uint256" }], "name": "setRewardDivisor", "outputs": [], "type": "function" }, { "constant": true, "inputs": [], "name": "deploymentReward", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [], "name": "sign", "outputs": [], "type": "function" }, { "constant": false, "inputs": [{ "name": "_dailyCosts", "type": "uint256" }], "name": "setDailyCosts", "outputs": [], "type": "function" }, { "constant": false, "inputs": [], "name": "payOneTimeReward", "outputs": [{ "name": "", "type": "bool" }], "type": "function" }, { "constant": false, "inputs": [], "name": "payReward", "outputs": [{ "name": "", "type": "bool" }], "type": "function" }, { "constant": false, "inputs": [], "name": "getDailyPayment", "outputs": [], "type": "function" }, { "constant": false, "inputs": [{ "name": "_deploymentReward", "type": "uint256" }], "name": "setDeploymentFee", "outputs": [], "type": "function" }, { "constant": false, "inputs": [], "name": "returnRemainingMoney", "outputs": [], "type": "function" }, { "constant": true, "inputs": [], "name": "rewardDivisor", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "inputs": [{ "name": "_contractor", "type": "address" }, { "name": "_hashOfTheTerms", "type": "bytes32" }, { "name": "_totalCosts", "type": "uint256" }, { "name": "_oneTimeCosts", "type": "uint256" }, { "name": "_minDailyCosts", "type": "uint256" }, { "name": "_rewardDivisor", "type": "uint256" }, { "name": "_deploymentReward", "type": "uint256" }], "type": "constructor" }];
  SampleOffer.binary = "606060405260405160e0806105368339610140604052905160805160a05160c0519351610100516101205160038054600160a060020a03191690961790955560049390935560009182556001949094556005849055600293909355600955600a556104c790819061006f90396000f36060604052361561008d5760e060020a6000350463039d56bd811461008f5780631632070c146100a25780631eb2e76b146100d55780632ca15122146100de5780633535cd52146100ff57806336dfe260146101205780637842a3a4146101355780639b29cb23146101b9578063d002462b146101db578063d40657631461020e578063f49c87e71461022c575b005b61023560085460a060020a900460ff1681565b61008d60043560085460a060020a900460ff16156103b35760085433600160a060020a039081169116146103cf57610002565b610235600a5481565b61008d600054341080156100f55750600754600014155b1561028b57610002565b61008d60043560085433600160a060020a039081169116146102bb57610002565b610235600a5460009034101561041b57610002565b61023560085460009060a060020a900460ff16156104985760085460e260020a6320afd919026060908152600160a060020a03909116906382bf64649060649060209060048187876161da5a03f1156100025750506040518051600160a060020a0316915034908381818185876185025a03f192505050156104c257506001610495565b61008d600354600090600160a060020a03908116339091161461036d57610002565b61008d60043560085460a060020a900460ff16156103e25760085433600160a060020a039081169116146103fe57610002565b61008d60085433600160a060020a039081169116146102e757610002565b61023560095481565b60408051918252519081900360200190f35b600880544260075573ffffffffffffffffffffffffffffffffffffffff1916331774ff0000000000000000000000000000000000000000191660a060020a1790555b565b600354600154600160a060020a039190911690600090606082818181858883f19350505050151561024757610002565b60028190556005548110156102e4576000600860146101000a81548160ff021916908302179055505b50565b6008547fa3912ec8000000000000000000000000000000000000000000000000000000006060908152600160a060020a039182169163a3912ec89130909116319060649060209060048185886185025a03f115610002575050604051511591506102899050576008805474ff000000000000000000000000000000000000000019169055565b60035460065460025460075462015180429190910304020391600160a060020a03919091169082606082818181858883f19350505050156102e457600680548201905550565b600354600160a060020a0390811633909116146103cf57610002565b60328110156103dd57610002565b600955565b600354600160a060020a0390811633909116146103fe57610002565b600a54678ac7230489e8000090111561041657610002565b600a55565b60085460a060020a900460ff16156104985760085460e260020a6320afd919026060908152600160a060020a03909116906382bf64649060649060209060048187876161da5a03f1156100025750506040518051600160a060020a0316915034908381818185876185025a03f192505050156104c2575060015b90565b600354600160a060020a03168134606082818181858883f19350505050156104c257506001610495565b61000256";

  if ("" != "") {
    SampleOffer.address = "";

    // Backward compatibility; Deprecated.
    SampleOffer.deployed_address = "";
  }

  SampleOffer.generated_with = "1.0.3";
  SampleOffer.contract_name = "SampleOffer";

  return SampleOffer;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.SampleOffer = factory;
}