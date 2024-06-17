const express = require('express');
const router = express.Router()
const service = require('../models/docentes_model.js')


//Funcion inicial
/** 
router.get('/', (req, res) => {
    db.query("SELECT * FROM persons")
        .then(data => res.send(data[0]))
        .catch(err => console.log(err))
});
**/

router.get('/', async (req, res) => {
    //res.send(await service.getEmployee());
    const employees = await service.getEmployee();
    res.json(employees) 
});


router.get('/:id', async (req, res) => {
    const paramId = req.params.id
    const employee = await service.getEmployeeById(paramId);
    if(employee.length == 0){
        res.status(404).json({'docente':false})
    }else{
        res.send(employee);
    }
});


router.delete('/:id', async (req, res) => {
    const paramId = req.params.id
    const employee = await service.deleteEmployeeById(paramId);    
    res.json({'eliminados': employee});    
});


router.post('/', async (req, res) => {
    const bodyJson = req.body
    const employee = await service.newOrUpdateEmployee(bodyJson);    
    res.status(201).json({'datos': employee});    
});


router.put('/:id', async (req, res) => {
    const bodyJson = req.body;
    const idParams = req.params.id || bodyJson.id; 
    const employee = await service.newOrUpdateEmployee(bodyJson, idParams);    
    res.status(201).json({'modificado': idParams});    
});



module.exports = router;