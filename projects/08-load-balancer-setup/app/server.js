const  http = require('http');
const os = require('os');

const PORT = 8080;

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(`Load Balanced App | served-by=${os.hostname()}\n`);
});

server.listen(PORT, () => {
  console.log(`Server running port ${PORT}`);
});
