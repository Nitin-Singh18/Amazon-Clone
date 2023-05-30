const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
     name : {
        type : String,
        required : true,
        trim : true,
     },
     description : {
        type : String,
        required : true
        ,trim : true,
     },

     //*List of images with those properties
     images : [
        {
            type :String,
            required : true,
        }
     ],
     quantity : {
        type : Number,
        required : true,

     },
     category : {
        type : String,
        required : true,
     },


});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;