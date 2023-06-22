const express = require('express');
const Product = require('../model/product');
const productRouter = express.Router();
const auth = require('../middleware/auth');

productRouter.get("/api/products", async (req , res)=>{
    try {
        //It is a query parameter
        console.log(req.query.category);
        const prodcuts = await Product.find({category : req.query.category});
        console.log(prodcuts);
        res.json(prodcuts);
    } catch (error) {
        
    }
});

productRouter.get("/api/products/search/:name", auth,async (req , res)=>{
    try {
        //It is a route parameter
        console.log(req.params.name);
        //$regex is a MongoDB operator that allows us to perform a regular expression search on the category field.
        // The i option makes the search case-insensitive
        const products = await Product.find({name : {$regex : req.params.name, $options : 'i'}});
        console.log(products);
        res.json(products);
    } catch (error) {
        
    }
});



module.exports = productRouter;