//aqui van todas las rutas relacioandas
const express= require('express');
const router=express.Router();
router.get('/test',(req, res)=>{
  res.send('<br/></br><div style="text-align: center;" >Test route response</div>');
});
module.exports=router;
