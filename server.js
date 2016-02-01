// server.js
// load the things we need
var express = require('express');
var app = express();
var os = require('os');

// set the view engine to ejs
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));

//var version = process.env.HOME;
//var uptime = process.env.LANGUAGE;

//typo

var fs = require('fs');
var obj = JSON.parse(fs.readFileSync('./info.json', 'utf8'));
var gh_version = obj.commit;
var gh_msg = obj.message;
var gh_date = obj.when;

// use res.render to load up an ejs view file

// index page 
app.get('/', function(req, res) {
    res.render('pages/index', {
		srv_uptime: Number((process.uptime()).toFixed(0)),
		gh_version: gh_version,
		gh_msg: gh_msg,
		gh_date: gh_date
    });
});

// about page 
app.get('/about', function(req, res) {
    res.render('pages/about');
});

app.listen(8080);
console.log('8080 is the magic port');
