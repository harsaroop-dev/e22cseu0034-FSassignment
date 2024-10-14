const express = require('express');
const app = express();
const userRoutes = require('./routes/userRoutes');
//const bcrypt = require('bcrypt');
require('dotenv').config();
const {MONGO_IP, MONGO_PORT, MONGO_USER, MONGO_PASSWORD} = require("./config/config");
MONGO_URL = `mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_IP}:${MONGO_PORT}/?authSource=admin`

const mongoose = require('mongoose');

app.use(express.json());

mongoose.connect(
    //"mongodb://root:root@172.29.0.3:27017/?authSource=admin"
    //"mongodb://root:root@mongo:27017/?authSource=admin"
    MONGO_URL)
    .then(() => {
        console.log("Connected to MongoDB!");
    })
    .catch((e) => {
        console.log("Error connecting to MongoDB: ", e);
    })
    
//user Routes
app.use('/api/users', userRoutes);

// Root route
app.get('/', (req, res) => {
    res.send("This is the root route");
});

// Registration route
app.get('/register', (req, res) => {
    res.send("This is the registration route");
});

// 404 Error handler
app.use((req, res) => {
    res.status(404).send("404 Not Found - The resource you're looking for doesn't exist.");
});

// Start the server
//const PORT = 3000;
const PORT = process.env.PORT;
app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});
