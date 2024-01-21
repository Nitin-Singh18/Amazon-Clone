const express = require('express');
const adminRouter = express.Router();
const admin  = require('../middleware/admin');
const { Product } = require('../model/product');
const Order = require('../model/order')

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

//API to get all the orders
adminRouter.get("/admin/get-orders", admin, async(req, res) =>{
    try {
       const orders =  await Order.find({});
       res.json(orders);
    } catch (error) {
        res.status(500).json({error : error.message});
        
    }
});


adminRouter.post("/admin/update-order-status", admin ,async(req, res)=> {
    try {
        const {id, status} = req.body;
        let order = await Order.findById(id);

        order.status = status;
        order = await order.save();
        res.json(order);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

adminRouter.get("/admin/analytics", admin, async(req, res)  => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;

        for(let i = 0; i <orders.length; i++){
                totalEarnings += orders[i].totalAmount;     
        }
        //fetch orders category wise 
       let mobileEarnings =  await fetchCategoryWiseProduct('Mobiles');
       let essentialsEarnings =  await fetchCategoryWiseProduct('Essentials');
       let appliancesEarnings =  await fetchCategoryWiseProduct('Appliances');
       let booksEarnings =  await fetchCategoryWiseProduct('Books');
       let fashionEarnings =  await fetchCategoryWiseProduct('Fashion');
    
        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        };

        res.json(earnings);

    } catch (error) {
        
    }
});

async function fetchCategoryWiseProduct(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        "products.product.category" : category,
    });
    for(let i = 0; i <categoryOrders.length; i++){
        for(let j = 0; j < categoryOrders[i].products.length; j++){
            earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
       
    }
    return earnings;
}

module.exports = adminRouter;