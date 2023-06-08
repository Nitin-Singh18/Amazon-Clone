const express = require('express');
const Product = require('../model/product');
const productRouter = express.Router();
const auth = require('../middleware/auth');

productRouter.get("/api/products", async (req , res)=>{
    try {
        console.log(req.query.category);
        const prodcuts = await Product.find({category : req.query.category});
        console.log(prodcuts);
        res.json(prodcuts);
    } catch (error) {
        
    }
});

module.exports = productRouter;