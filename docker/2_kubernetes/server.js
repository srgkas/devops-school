var http = require('http');
var handleRequest = function(request, response) {
  response.writeHead(200);
  const name = process.env.NAME;
  response.end(`Hello, ${name}!`);
};
var helloServer = http.createServer(handleRequest);
helloServer.listen(8080);
