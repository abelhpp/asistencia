const express = require('express');
const router = express.Router()
const service = require('../models/curos_model')


router.get('/', async (req, res) => {
    //res.send(await service.getEmployee());
    const cursos = await service.getCursos();
    res.send(cursos) 
});


router.get('/:id', async (req, res) => {
    const paramId = req.params.id
    const employee = await service.getCursosById(paramId);
    if(employee.length == 0){
        res.status(404).json({'curso':false})
    }else{
        res.send(employee);
    }
});


router.delete('/:id', async (req, res) => {
    const paramId = req.params.id
    const employee = await service.deleteCursosById(paramId);    
    res.json({'eliminados': employee});    
});

router.post('/', async (req, res) => {
    const bodyJson = req.body
    const employee = await service.newCurso(bodyJson);    
    res.status(201).json({'creados': employee});    
});

router.put('/:id', async (req, res) => {
    const bodyJson = req.body;
    const idParams = req.params.id || bodyJson.id; 
    const employee = await service.newOrUpdateEmployee(bodyJson, idParams);    
    res.status(201).json({'modificado': idParams});    
});



module.exports = router;