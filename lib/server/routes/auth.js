const express = require('express');
const User = require('../model/user');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();
// JsonWebToken
const jwt = require('jsonwebtoken');

//*SIGN UP Route
authRouter.post('/api/signup', async (req, res) => {
    try {
        //destructing variables
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({
            email
        });
        //if a user exists with entered email then a res will be returned with status code 400(ClientSideError)
        //and a message. And the code will be stopped.
        if (existingUser) {
            return res.status(400).json({ msg: 'Useer with the same email already exists!' });
        }
        //hashedpassword
        hashedPassword = await bcryptjs.hash(password, 8)
        //Instance of User model
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });

        //Save user object
        user = await user.save();

        //return json object with saved user object
        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});

//* SIGN IN Route
authRouter.post('/api/signin', async (req, res) => {
    try {
        const {email, password} = req.body;

        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg : "User with this email doesn't exist."});
        }
        //checking if the entered password is correct
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg : "Incorrect password."});
        }

        const token = jwt.sign({id : user._id}, "passwordKey");

        //*... is used to extract all the properties of user
        res.json({token, ...user._doc});
    } catch (error) {
        res.status(500).json({ error: error.message });
        
    }
},);

module.exports = authRouter;