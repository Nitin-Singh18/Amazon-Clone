const express = require('express');
const { Product } = require('../model/product');
const productRouter = express.Router();
const auth = require('../middleware/auth');

productRouter.get("/api/products", async (req , res)=>{
    try {
        //It is a query parameter
        console.log(req.query.category);
        const prodcuts = await Product.find({category : req.query.category});
        console.log(prodcuts);
        res.json(prodcuts);
    } catch (e) {
        res.status(500).json({ error: e.message });
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
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.post("/api/rate-product", auth, async (req, res)=> {
    try {
        const {id, rating} = req.body;

        let product = await Product.findById(id);
        
        for (let index = 0; index < product.ratings.length; index++) {
            if (product.ratings[index].userId == req.user) {
                product.ratings.splice(index, 1);
                break;
            }
            
        }

        const ratingSchema = {
            userId : req.user,
            rating,
        }
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);


    } catch (e) {
        res.status(500).json({ error: r.message });
    }
});

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
    try {
        let products = await Product.find();

        products = products.sort((a,b)=>{
            let aSum = 0;
            let bSum = 0;
            
            a.ratings.forEach(element => {
                aSum += element.rating; 
            });
            b.ratings.forEach(element => {
                bSum += element.rating; 
            });
            return b-a;
        });

        res.json(products[0]);

    } catch (e) {
        console.log(e.message);
        res.status(500).json({ error: e.message });
    }
});



module.exports = productRouter;