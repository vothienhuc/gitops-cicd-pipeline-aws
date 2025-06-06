const express = require('express');
const mysql = require('mysql2/promise');
const redis = require('redis');
const path = require('path');
const ejs = require('ejs');

const app = express();
const port = 3000;

// ======= MySQL Connection Setup =======
const pool = mysql.createPool({
  host: process.env.mysql_hostname || 'my-mysql',
  user: process.env['mysql-username'] || 'defaultuser',
  password: process.env['mysql-password'] || 'defaultpass',
  port: process.env.mysql_port || 3306,
  database: 'sqlDB',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// ======= Redis Connection Setup =======
const redisClient = redis.createClient({
  url: `redis://${process.env.redis_hostname || 'redis-master'}:${process.env.redis_port || 6379}`
});

// Track connection statuses
let mysqlConnected = false;
let redisConnected = false;

// Attempt MySQL connection
pool.getConnection()
  .then(connection => {
    console.log('✅ Connected to MySQL (RDS)');
    mysqlConnected = true;
    connection.release();
  })
  .catch(err => {
    console.error('❌ MySQL connection error:', err.message);
  });

// Attempt Redis connection
redisClient.connect()
  .then(() => {
    console.log('✅ Connected to Redis');
    redisConnected = true;
  })
  .catch(err => {
    console.error('❌ Redis connection error:', err.message);
  });

// ======= Express Configuration =======

// Serve static files (CSS, JS, images)
app.use(express.static(path.join(__dirname, 'public')));

// Set EJS as the templating engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Root route renders index.ejs and passes connection statuses
app.get('/', (req, res) => {
  res.render('index', {
    mysqlConnected,
    redisConnected
  });
});

// Start the server
app.listen(port, () => {
  console.log(`🚀 App running on http://localhost:${port}`);
});

// Gracefully handle uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('❗ Uncaught Exception:', err);
});
