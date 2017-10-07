let express = require('express');
let router = express.Router();
let mysql      = require('mysql');
let connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'mysql13',
    database : 'unicorn'
});
connection.connect();

let coef_price_Tickets = [];
for(let i=0;i <=4; i++){
    coef_price_Tickets.push(1/(3 + 2 * i));
}
console.log(coef_price_Tickets);
router.get('/', function(req, res, next) {

    connection.query('SELECT * FROM cities;', function (error0, results0, fields) {
        if (error0)  console.log( error0);
        connection.query('SELECT * FROM att_categories;', function (error1, results1, fields) {
            if (error1)  console.log( error1);
            // console.log(results1);
            // connection.end();
            res.render('index', { cities: results0, categories : results1 });
        });
    });
});

router.post('/process', function(req, res, next) {
    let price = parseFloat(req.body.price);
    let cityFrom = req.body.cityFrom ;
    let cityTo = req.body.cityTo ;
    let days = parseInt(req.body.days);
    let attr = req.body.attr ;
    let date = req.body.date ;
    let tickets_Price = 1/(3 + 2 * (days - 1)) * price;
    let tickets = null;

    // поиск подходящих билетов
    console.log(tickets_Price);
    //TODO если город родной - то только развалечения ищем

    // select tickets
    connection.query("SELECT * FROM unicorn.tickets where id_from = ? and id_to = ? and tickets.datetime > ? and tickets.price <= ? ", [cityFrom, cityTo, date, tickets_Price],  function (error, tickets, fields) {
        if (error) {
            console.log( error);
            res.send('%TICKET-ERROR%');
            return;
        }
        if (tickets.length ===  0){
            res.send('%NO-TICKETS%');
            return;
        }

        let hotel_price = ((price - tickets_Price) / 2) / days;
        // select hostels
        connection.query("SELECT * FROM unicorn.rooms where id_hostel = (SELECT id from hotels where id_city = ? ) and price <= ? ", [cityTo, hotel_price],  function (error0, rooms, fields) {
            if (error0) {
                console.log( error0);
                res.send('%HOTEL-ERROR%');
                return;
            }
            if (rooms.length ===  0){
                res.send('%NO-ROOMS%');
                return;
            }
            console.log(rooms);
            let attr_price = price - tickets_Price - hotel_price;

            // select hostels
            connection.query("SELECT * FROM unicorn.attractions where id_city = ? and id_cat = ? and price <= ?", [cityTo, attr, attr_price],  function (error1, attractions, fields) {
                if (error1) {
                    console.log( error1);
                    res.send('%ATTR-ERROR%');
                    return;
                }
                if (attractions.length ===  0){
                    res.send('%NO-ATTR%');
                    return;
                }

                console.log(attractions);
                res.send(attractions);
            });


            // res.send(rooms);
        });


        // res.send(results0);
    });


    // console.log(req.body);


    /** TODO: ответа - массив объектов - результата запрса */
    // res.send(price);

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
