const db=require('./db');


module.exports.getCursos = async () =>{
    const [rows] = await db.query("SELECT id, ano AS año, División, Asignatura, turno, persons_id AS docente "+
                                        "FROM cursos WHERE estado = 1;")
    //.catch(err => console.log(err));
    return rows;
}



module.exports.getCursosById = async (id) =>{
    const [rows] = await db.query("SELECT id, ano AS año, División, Asignatura, turno, persons_id AS docente "+ 
               "FROM cursos WHERE id=" + id)
    return rows;
}



module.exports.deleteCursosById = async (id) =>{

    const [rows] = await db.query("UPDATE cursos SET estado = 0 WHERE id = ? AND estado != 0;", [id]);
    return rows.affectedRows;

}


module.exports.newCurso = async (obj) =>{
    const personsId = obj.persons_id !== undefined ? obj.persons_id : 0;

    const [row] = await db.query("INSERT INTO cursos (ano, División, Asignatura, turno, persons_id)"+
            "VALUES (?, ?, ?, ?, ?);", [obj.ano, obj.División, obj.Asignatura, obj.turno, personsId]);    
    return row.affectedRows;
}