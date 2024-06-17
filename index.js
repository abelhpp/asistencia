const express = require('express');
require('express-async-errors'),
    app = express();
    bodyParser = require('body-parser');
const db = require('./models/db.js'),
    employeeRoutes = require('./controllers/docentes_controllers.js');
    cursosRoutes = require('./controllers/cursos_controllers');
    

    // middleware maneja las res y req
app.use(bodyParser.json());

    //points
app.use('/api/docente', employeeRoutes);
app.use('/api/curso', cursosRoutes);






// Middleware para manejar errores
app.use((err, req, res, next) => {    
    console.log(err);
    res.status(err.status || 500).send('Error de servidor!!');
});


db.query("SELECT 1")
    .then(() => {
        console.log('La conexión a la base de datos fue exitosa.');
        // Escuchar en el puerto 3000 una vez que la conexión a la base de datos sea exitosa
        app.listen(3000, () => console.log('El servidor se inició en el puerto 3000'));
    })
    .catch(err => console.log('Error al conectar con la base de datos: ', err));