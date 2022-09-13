import asyncHandler from 'express-async-handler';
import Bcrypt from 'bcrypt';
import mysql from 'mysql';
import jwt from 'jsonwebtoken';

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

    const connection = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "quiz"
    });

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


export {
    register
};
