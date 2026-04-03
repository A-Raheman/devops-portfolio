const http = require('http');
const os = require('os');

const PORT = 8080;
const APP_VERSION = process.env.APP_VERSION || 'v1';

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(`Production CI/CD App ${APP_VERSION} is running | served-by=${os.hostname()}\n`);
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

