require("dotenv").config();
const express = require("express");
const mysql = require("mysql2/promise");
const session = require("express-session");
const bcrypt = require("bcrypt");

const server = express();

server.use(express.static(__dirname + "/public/", {index:false /*потому что CheckAuth не срабатывает*/}));
server.use(express.json());

server.use(session({
    secret: process.env.SECRET_KEY,
    resave: false,
    saveUninitialized: true,
    cookie: {secure: false}
}));

const conn = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

server.get("/", CheckAuth, (req, res) => {
    res.sendFile(__dirname + "/public/index.html")
});

server.get("/auth", (req, res) => {
    res.sendFile(__dirname + "/public/auth.html")
});

function CheckAuth(req, res, next) {
    if (req.session.user) {
        next();
    } else {
        res.redirect("/auth");
    }
}

server.get("/logout", (req, res) => {
    req.session.destroy(err => {
        if (err) {
            return res.status(500).send({message: "Ошибка выхода"})
        }
        res.redirect("/auth")
    })
})

server.post("/auth/login", async (req, res) => {
    try {
        const {email,password} = req.body;

        if (!email || !password) {
            return res.status(400).send({message: "Введите email и пароль"})
        }

        const [results] = await conn.query("Select * From users Where email = ?", [email]);

        if (results.length == 0) {
            return res.send({message: "Некорректный логин или пароль"});
        }

        const user = results[0];

        const isMatch = await bcrypt.compare(password, user.password_u)
        if (!isMatch) {
            return res.status(401).send({message: "Некорректный логин или пароль"});
        }

        req.session.user = {
            id: user.id_u,
            email: email
        };
        return res.status(200).send({message: "Успешная авторизация", redirect: "/"});
    } catch (error) {
        console.log(error)
        return res.status(500).send({message: "Ошибка сервера"})
    }
})

server.post("/auth/registration", async (req, res) => {
    try {
        const {email,password} = req.body;

        if (!email || !password) {
            return res.status(400).send({message: "Введите email и пароль"})
        }

        const [userExists]  = await conn.query("Select * From users Where email = ?", [email]);
        if (userExists.length > 0) {
            return res.status(409).send({message: "Данный email уже занят"})
        }

        const hashPassword = await bcrypt.hash(password,10);
        const [result] = await conn.query("Insert Into users (email, password_u) Values (?,?)", [email,hashPassword]);

        req.session.user = {
            id: result.insertId,
            email:email
        };
        return res.status(200).send({message: "Успешная регистрация", redirect: "/"});
    } catch (error) {
        console.log(error)
        return res.status(500).send({message: "Ошибка сервера"})
    }
})

server.post("/proposalSend", async (req,res) => {
    try {
        const proposal = req.body.proposal;
        const id = req.session.user.id;

        if (!proposal) {
            return res.status(400).send({message: "Введите ваше предложение"});
        }
        
        await conn.query("Insert Into proposals (id_u_fk, note) values (?,?)", [id, proposal]);
        return res.status(200).send({message: "Предложение успешно отправлено", redirect: "/"});
    } catch (error) {
        console.log(error)
        return res.status(500).send({message: "Ошибка сервера"})
    }
})


server.listen(process.env.PORT, () => {
    console.log("Сервер успешно запущен")
});