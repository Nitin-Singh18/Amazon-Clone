const mongoose = require('mongoose');
const { productSchema } = require('./product');

const orderSchema = mongoose.Schema({
    userId : {
        type: String,
        required: true
    },
    totalAmount: {
        type: Number,
        require : true,
    },
    address: {
        type: String,
        default: '',
    },
    products: [
        {
          product: productSchema,
          quantity: {
            type: Number,
            required: true,
          },
        },
    ],
    orderAt: {
        type: Number,
        require: true,
    },

    status: {
        type: Number,
        default:0,
    }

});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;