const express = require('express');
const userRouter = express.Router();
const auth = require("../middleware/auth");
const { Product } = require('../model/product');
const User = require('../model/user');

userRouter.post('/api/add-to-cart', auth, async(req, res)=> {
    try {
       const {id} = req.body;
       const product = await Product.findById(id);

       let user = await User.findById(req.user);

       if(user.cart.length == 0){
         user.cart.push({product, quantity : 1});
       }else{
        let isProductFound = false;
        for(let i = 0; i < user.cart.length; i++){
            if( user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
            }
        }

        if(isProductFound){
            let producttt = user.cart.find((productt) => productt.product._id.equals(product._id),);
        producttt.quantity += 1;
        }else{
            user.cart.push({product, quantity});
        }
       }
       user = await user.save();
       console.log("Added to cart");
       res.json(user);
    } catch (error) {
        res.status(500).json({error : error.message});
    }
}) ;
module.exports = userRouter;