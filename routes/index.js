let express = require('express');
let router = express.Router();
let mysql      = require('mysql');
let connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'mysql13',
    database : 'unicorn'
});
router.get('/', function(req, res, next) {

    connection.connect();
    connection.query('SELECT * FROM cities;', function (error, results0, fields) {
        if (error) throw error;
        connection.query('SELECT * FROM att_categories;', function (error, results1, fields) {
            if (error) throw error;
            console.log(results1);
            connection.end();
            res.render('index', { cities: results0, categories : results1 });
        });
    });
});

router.post('/process', function(req, res, next) {
    let price = req.body.price;
    let cityFrom = req.body.cityFrom ;
    let cityTo = req.body.cityTo ;
    let days = req.body.days ;
    let attr = req.body.attr ;
    let date = req.body.date ;
    let tickets = null;
    connection.connect();
    connection.query('SELECT * FROM cities;', function (error, results0, fields) {
        if (error) throw error;
        connection.query('SELECT * FROM att_categories;', function (error, results1, fields) {
            if (error) throw error;
            console.log(results1);
            connection.end();
            res.render('index', { cities: results0, categories : results1 });
        });
    });
    console.log(req.body);


    /** TODO: ответа - массив объектов - результата запрса */
    res.send(price);

    // let connection = mysql.createConnection({
    //     host     : 'localhost',
    //     user     : 'root',
    //     password : 'mysql13',
    //     database : 'unicorn'
    // });
    // connection.connect();
    // connection.query('SELECT * FROM cities;', function (error, results0, fields) {
    //     if (error) throw error;
    //     connection.query('SELECT * FROM att_categories;', function (error, results1, fields) {
    //         if (error) throw error;
    //         console.log(results1);
    //         connection.end();
    //         res.render('index', { cities: results0, categories : results1 });
    //     });
    // });
});

module.exports = router;
