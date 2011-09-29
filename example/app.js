// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
window.add(label);
window.open();

// TODO: write your module tests here
var keep_me_logged = require('org.adamantio.kml');
Ti.API.info("module is => " + keep_me_logged);

label.text = keep_me_logged.example();

Ti.API.info("module exampleProp is => " + keep_me_logged.exampleProp);
keep_me_logged.exampleProp = "This is a test value";

if (Ti.Platform.name == "android") {
	var proxy = keep_me_logged.createExample({message: "Creating an example Proxy"});
	proxy.printMessage("Hello world!");
}