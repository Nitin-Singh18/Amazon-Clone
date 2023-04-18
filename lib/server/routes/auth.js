const express = require('express');
const User = require('../model/user');
const bcryptjs = require('bcryptjs');

const authRouter = express.Router();
// JsonWebToken
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

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
});


//verifying jwt
authRouter.post('/tokenIsValid', async (req, res)=> {
    try {
        //accepting token thorugh header
        const token = req.header('x-auth-token');
        //if token is null return false
        if(!token) return res.json(false);
        
        //checking if the token is valid or not
        const verified = jwt.verify(token, 'passwordKey');
        if(!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if(!user) return res.json(false);

        res.json(true);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//get user data
//*auth is a middleware function that is passed as a parameter to 
//*check whether the user is authenticated and authorized to access the route.
authRouter.get("/", auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token : req.token});
});

module.exports = authRouter;