//Importing from packages
const express = require('express');
const mongoose = require('mongoose');

//Importing from other files
const authRouter = require('./routes/auth');

//Init
const PORT = 3000;
// const PORT = 5500;

const app = express();
const DB = 'mongodb+srv://nitin:7827188727@cluster0.pk27svx.mongodb.net/?retryWrites=true&w=majority'

//middleware
app.use(express.json());
app.use(authRouter);



//Connections

mongoose.connect(DB).then(() => {
    console.log('Connection Successful');
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, 
    '0.0.0.0',
    // "",
    // '10.0.2.2',
     () => {
    console.log(`Connected at port ${PORT}`);
});