const express = require('express');
const adminRouter = express.Router();
const admin  = require('../middleware/admin');
const { Product } = require('../model/product');

//API to add product
adminRouter.post('/admin/add-product', admin, async(req, res)=> {
    try {
        const {name, description,images, quantity, price, category } = req.body;

        let product = new Product({
            name, 
            description,
            images,
             quantity,
             price,
              category,
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({error : error.message});
    }
}) 

//API to get all the products
adminRouter.get("/admin/get-products", admin, async(req, res) =>{
    try {
       const products =  await Product.find({});
       res.json(products);
    } catch (error) {
        res.status(500).json({error : error.message});
        
    }
})
//API to delete 
adminRouter.delete("/admin/delete-product", admin ,async(req, res)=> {
    try {
        const {id} = req.body;
        const product = await Product.findByIdAndDelete(id);
        
        res.json({msg : "Deleted Successfully"});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})
module.exports = adminRouter;