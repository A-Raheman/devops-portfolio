const http = require('http');
const os = require('os');
const client = require('prom-client');

const PORT = 8080;

const register = new client.Registry();
client.collectDefaultMetrics({ register });

const httpRequestCounter = new client.Counter({
  name: 'app_http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status']
});

register.registerMetric(httpRequestCounter);

const server = http.createServer(async (req, res) => {
  if (req.url === '/metrics') {
    res.writeHead(200, { 'Content-Type': register.contentType });
    res.end(await register.metrics());
    return;
  }

  httpRequestCounter.inc({
    method: req.method,
    route: req.url,
    status: 200
  });

  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(`Monitored App is running | served-by=${os.hostname()}\n`);
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

