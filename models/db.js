
const mysql      = require('mysql2/promise');
const mysqlPool = mysql.createPool({
  host     : 'localhost',
  user     : 'root',
  password : '',
  database        : 'attendance'
});



module.exports = mysqlPool

/*
mysqlPool.query("SELECT 1")
.then(data => console.log('db connection succeeded')) // poner data para probar
.catch(err => console.log('db connection failes. '))*/