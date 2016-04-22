"use strict";

var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var factory = function factory(Pudding) {
  // Inherit from Pudding. The dependency on Babel sucks, but it's
  // the easiest way to extend a Babel-based class. Note that the
  // resulting .js file does not have a dependency on Babel.

  var Session = (function (_Pudding) {
    _inherits(Session, _Pudding);

    function Session() {
      _classCallCheck(this, Session);

      _get(Object.getPrototypeOf(Session.prototype), "constructor", this).apply(this, arguments);
    }

    return Session;
  })(Pudding);

  ;

  // Set up specific data for this class.
  Session.abi = [{ "constant": true, "inputs": [{ "name": "", "type": "address" }], "name": "registrantsPaid", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "organizer", "outputs": [{ "name": "", "type": "address" }], "type": "function" }, { "constant": false, "inputs": [{ "name": "recipient", "type": "address" }, { "name": "amount", "type": "uint256" }], "name": "refundTicket", "outputs": [], "type": "function" }, { "constant": false, "inputs": [], "name": "destroy", "outputs": [], "type": "function" }, { "constant": false, "inputs": [{ "name": "newquota", "type": "uint256" }], "name": "changeQuota", "outputs": [], "type": "function" }, { "constant": true, "inputs": [], "name": "quota", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": true, "inputs": [], "name": "numRegistrants", "outputs": [{ "name": "", "type": "uint256" }], "type": "function" }, { "constant": false, "inputs": [], "name": "buyTicket", "outputs": [{ "name": "success", "type": "bool" }], "type": "function" }, { "inputs": [], "type": "constructor" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "_from", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }], "name": "Deposit", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "_to", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }], "name": "Refund", "type": "event" }];
  Session.binary = "606060405260008054600160a060020a0319163317815560016003556002556102488061002c6000396000f36060604052361561006c5760e060020a600035046313381fbf811461006e5780636120326514610086578063705099b91461009857806383197ef0146100bf578063a977c71e146100e9578063cebe09c91461010c578063ec3a6f7314610115578063edca914c1461011e575b005b61013560043560016020526000908152604090205481565b610135600054600160a060020a031681565b61006c60043560243560008054600160a060020a039081163391909116146101a557610241565b61006c600054600160a060020a039081163391909116141561024657600054600160a060020a0316ff5b61006c600435600054600160a060020a0390811633919091161461019c576101a2565b61013560035481565b61013560025481565b610135600354600254600091901061013f57610199565b6060908152602090f35b600160a060020a03331680825260016020819052604080842034908190556002805490930190925560609283526080919091527fe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c91a15060015b90565b60038190555b50565b600160a060020a038316815260016020526040812054821415610241575030600160a060020a0381163182901061024157600160a060020a038316600083606082818181858883f150506040808320848452600160209081529390556002805460001901905580519384529183015280517fbb28353e4598c3b9199101a66e0989549b659a59a54d2c27fbb183f1932c8e6d9281900390910190a15b505050565b56";

  if ("" != "") {
    Session.address = "";

    // Backward compatibility; Deprecated.
    Session.deployed_address = "";
  }

  Session.generated_with = "1.0.3";
  Session.contract_name = "Session";

  return Session;
};

// Nicety for Node.
factory.load = factory;

if (typeof module != "undefined") {
  module.exports = factory;
} else {
  // There will only be one version of Pudding in the browser,
  // and we can use that.
  window.Session = factory;
}