const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
 
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from EC2!',
    deployed_by: 'GitHub Actions + AWS CodeDeploy',
    timestamp: new Date().toISOString()
  });
});
 
app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});
 
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
 
