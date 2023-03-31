const express = require('express');
const User = require('../model/user');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();

//*SIGN UP
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

module.exports = authRouter;