var path = require('path');
var dir = path.join(__dirname, "../../build/test");

var Deployer = require('../../../script/deployer');

var dep = new Deployer(dir);
require('../deploy.js')(dep, function (err, dep) {
    if (err) throw err;
    dep.writeContracts(path.join(__dirname, "contracts.json"), false, true, path.join(__dirname, "libraries.json"));
    console.log("Done.");
});