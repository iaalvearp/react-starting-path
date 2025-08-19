// Instala express y el conector de mysql: npm install express mysql2
const express = require('express');
const mysql = require('mysql2/promise');
const app = express();

// Configura tu conexión a la base de datos
const dbConfig = {
    host: 'localhost:3306',
    user: 'alpes',
    password: '4826',
    database: 'actform'
};

// Endpoint para obtener un reporte por ID
app.get('/api/reporte/:id', async (req, res) => {
    try {
        const connection = await mysql.createConnection(dbConfig);
        const [rows] = await connection.execute(
            'SELECT * FROM reporte WHERE id_actividad = ?',
            [req.params.id]
        );
        connection.end();

        if (rows.length > 0) {
            const reporte = rows[0];
            // Las URLs de las imágenes ya vienen como un string separado por comas
            // Lo convertimos en un array para que sea más fácil de usar en el frontend
            if (reporte.urls_imagenes) {
                reporte.urls_imagenes = reporte.urls_imagenes.split(',').map(url => url.trim());
            } else {
                reporte.urls_imagenes = [];
            }
            if (reporte.urls_capturas) {
                reporte.urls_capturas = reporte.urls_capturas.split(',').map(url => url.trim());
            } else {
                reporte.urls_capturas = [];
            }

            res.json(reporte);
        } else {
            res.status(404).json({ message: 'Reporte no encontrado' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.listen(3000, () => {
    console.log('Servidor API corriendo en http://localhost:3000');
});