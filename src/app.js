var http = require('http');
var express = require('express');
var appengine = require('appengine');

var app = express();
app.set('port', 8080);

var router = express.Router();
router.get('/', function(req, res) {
  res.send('Hello world');
});

router.get('/_ah/health', function(req, res) {
  res.send('ok');
});

router.get('/_ah/start', function(req, res) {
  res.send('ok');
});

router.get('/_ah/stop', function(req, res) {
  res.send('ok');
  process.exit();
});

app.use(appengine.middleware.base);
app.use(router);

var server = http.createServer(app).listen(app.get('port'), function() {
  console.info('Using Node %s.', process.version);
  console.info('Express server listening on port %d in %s mode.', app.get('port'), app.get('env'));
});
