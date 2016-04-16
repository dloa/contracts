"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var DAOTokenSaleProxyTransferer = (function (_Pudding) {
    _inherits(DAOTokenSaleProxyTransferer, _Pudding);

    function DAOTokenSaleProxyTransferer() {
      _classCallCheck(this, DAOTokenSaleProxyTransferer);

      _get(Object.getPrototypeOf(DAOTokenSaleProxyTransferer.prototype), "constructor", this).apply(this, arguments);
    }

    return DAOTokenSaleProxyTransferer;
  })(Pudding);

  ;

  // Set up specific data for this class.
  DAOTokenSaleProxyTransferer.abi = [{ "constant": true, "inputs": [], "name": "dao", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": false, "inputs": [], "name": "sendValues", "outputs": [], "type": "function" }, { "inputs": [{ "name": "_owner", "type": "address" }, { "name": "_dao", "type": "address" }], "type": "constructor" }];
  DAOTokenSaleProxyTransferer.binary = "606060408181528061032e833960a090525160805160008054600160a060020a031990811684178255600180549091168317905561004e90600160a060020a0330163181141561005e57610175565b50506101b6806101786000396000f35b600160009054906101000a9004600160a060020a0316905080600160a060020a0316634b6753bc604051817c01000000000000000000000000000000000000000000000000000000000281526004018090506020604051808303816000876161da5a03f1156100025750506040515142119050806101495750604080516000547f13d4bc24000000000000000000000000000000000000000000000000000000008252600160a060020a039081166004830152915183926313d4bc24923090911631916024808301926020929190829003018185886185025a03f11561000257505060405151159150505b156101755760405160008054600160a060020a039081169230909116319082818181858883f150505050505b5056606060405236156100355760e060020a60003504634162169f81146100405780638da5cb5b14610052578063be2430fe14610064575b610082610084610068565b610086600154600160a060020a031681565b610086600054600160a060020a031681565b6100825b600030600160a060020a031631600014156100a3576101b3565b005b565b60408051600160a060020a03929092168252519081900360200190f35b50604080516001547f4b6753bc0000000000000000000000000000000000000000000000000000000082529151600160a060020a0392909216918291634b6753bc91600482810192602092919082900301816000876161da5a03f1156100025750506040515142119050806101885750604080516000547f13d4bc24000000000000000000000000000000000000000000000000000000008252600160a060020a0390811660048301529151838316926313d4bc2492309190911631916024828101926020929190829003018185886185025a03f11561000257505060405151159150505b156101b35760008054604051600160a060020a0391821692913016319082818181858883f150505050505b5056";

  if ("" != "") {
    DAOTokenSaleProxyTransferer.address = "";

    // Backward compatibility; Deprecated.
    DAOTokenSaleProxyTransferer.deployed_address = "";
  }

  DAOTokenSaleProxyTransferer.generated_with = "1.0.3";
  DAOTokenSaleProxyTransferer.contract_name = "DAOTokenSaleProxyTransferer";

  return DAOTokenSaleProxyTransferer;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.DAOTokenSaleProxyTransferer = factory;
}