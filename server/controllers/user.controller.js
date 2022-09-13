import asyncHandler from 'express-async-handler';
import Bcrypt from 'bcrypt';
import mysql from 'mysql';
import jwt from 'jsonwebtoken';

const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "raptor47",
    database: "quiz"
});

const register = asyncHandler(async (req, res) => {
    const salt = await Bcrypt.genSalt(10);
    const userPassword = await Bcrypt.hash(req.body.password, salt);

    const user = {
        email: req.body.email,
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        phone: req.body.phone,
    };

    const token = jwt.sign(user, 'private_key');

    user.password = userPassword;
    user.token = token;

    connection.connect(err => {
        if (err) {
            console.log(err);
        }

        const query = "INSERT INTO user (email, first_name, last_name, password, phone, token) VALUE ?";
        const values = [[user.email, user.first_name, user.last_name, user.password, user.phone, user.token]];

        connection.query(query, [values], (error, result) => {
            if (error) {
                console.log(error);
            }

            console.log('Affected rows: ');
            console.log(result.affectedRows);
        });
    });

    return res.status(201).json({ created: true });
});

const login = asyncHandler(async (req, res) => {
    const user = {
        email: req.body.email,
        password: req.body.password
    };

    connection.connect(err => {
        if (err) {
            console.log(err);
        }

        const query = "SELECT password, token FROM user WHERE email=?";
        const values = [[user.email]];

        connection.query(query, [values], async (error, result) => {
            if (error) {
                console.log(error);
            }

            console.log('Affected rows: ');
            console.log(result.affectedRows);

            const data  = result[0];

            const hashed_pass = data.password;
            const token = data.token;

            const isUserValidated = await Bcrypt.compare(user.password, hashed_pass);

            let response = {
                error: "Invalid username or password!"
            }

            let statusCode = 404;

            if(isUserValidated) {
                response = {
                    token: token
                }

                statusCode = 200;
            }

            res.status(statusCode).json(response);

        });
    });
});


export {
    register,
    login
};
