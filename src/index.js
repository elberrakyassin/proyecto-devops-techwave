const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  // Cambiamos el mensaje y añadimos un estilo verde para identificar la v2
  res.send(`
    <body style="font-family: sans-serif; text-align: center; padding-top: 50px;">
      <h1 style="color: #28a745;">TechWave Solutions - VERSIÓN 2 (GREEN)</h1>
      <p style="font-size: 1.2em;">Estado: <strong>Actualización Exitosa mediante CI/CD</strong></p>
      <div style="margin-top: 20px; padding: 10px; border: 2px solid #28a745; display: inline-block;">
        Ambiente de Producción: GREEN
      </div>
    </body>
  `);
});

app.listen(port, () => {
  console.log(`Aplicación TechWave v2 escuchando en el puerto ${port}`);
});