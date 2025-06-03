const express = require('express');
const path = require('path');
const app = express();
const port = 3000; // Or any port you prefer

// Serve static files (like index.html) if needed
app.use(express.static(path.join(__dirname, 'public')));

// Route definition
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
