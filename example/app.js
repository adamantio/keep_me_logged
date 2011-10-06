// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
 

var keep_me_logged = require('org.adamantio.kml');

keep_me_logged.addEventListener('credentials_saved', function(e){
                                    alert("the credencial is " + e.result);
                                });

keep_me_logged.addEventListener('credentials_error', function(e){
                                    alert("we have a problem " + e.result);
                                });



keep_me_logged.
({"host" :"localhost",
                                                   "port" : "3000",
                                                   "username":"foo",
                                                   "password":"bar"
                                                 });

window.open();

