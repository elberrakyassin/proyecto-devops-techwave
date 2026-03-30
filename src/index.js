const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('<h1>TechWave Solutions - Proyecto DevOps</h1><p>Estado: En funcionamiento</p>');
});

app.listen(port, () => {
  console.log(`Aplicación TechWave escuchando en http://localhost:${port}`);
});