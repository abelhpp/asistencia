const db=require('./db');

module.exports.getEmployee = async () =>{
    const [rows] = await db.query("SELECT * FROM persons WHERE estado = 1")
    //.catch(err => console.log(err));
    console.log(rows);
    return rows;
}

module.exports.getEmployeeById = async (id) =>{
    const [rows] = await db.query("SELECT id, dni, digito, lastname, name, cargo FROM persons WHERE estado = 1 and id=?", [id])
    return rows;
}


module.exports.deleteEmployeeById = async (id) =>{
    //const [rows] = await db.query("DELETE FROM persons WHERE id=?", [id])
    const [rows] = await db.query("UPDATE persons SET estado = 0 WHERE id = ? AND estado != 0", [id]);
    return rows.affectedRows;
}

module.exports.newOrUpdateEmployee = async (obj, id=0) =>{
    //const [rows] = await db.query("DELETE FROM persons WHERE id=?", [id])
    const [rows] = await db.query("CALL insertar_o_actualizar(?,?,?,?,?,?,?)",
                [id, obj.dni, obj.digito, obj.lastname, obj.name, obj.cargo,obj.estado]);
    return rows.affectedRows;
}