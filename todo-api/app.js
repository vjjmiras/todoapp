var restify = require('restify');
var corsMiddleware = require('restify-cors-middleware');

var controller = require('./controllers/items');
var serverinfo = require('./controllers/serverinfo');

var db = require('./models/db');
var model = require('./models/items');

model.connect(db.params, function(err) {
    if (err) throw err;
});

var server = restify.createServer()
    .use(restify.plugins.fullResponse())
    .use(restify.plugins.queryParser())
    .use(restify.plugins.bodyParser());

const cors = corsMiddleware({ origins: ['*'] });
server.pre(cors.preflight);
server.use(cors.actual);
    
controller.context(server, '/todo/api', model); 
serverinfo.context(server, '/todo/api');

var port = process.env.PORT || 8080;
server.listen(port, function (err) {
    if (err) {
        console.error(err);
    }
    else {
        console.log('App is ready at port ' + port);
    }
});


if (process.env.environment == 'production') {
    process.on('uncaughtException', function (err) {
        console.error(JSON.parse(JSON.stringify(err, ['stack', 'message', 'inner'], 2)))
    });
}


