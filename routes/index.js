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
for(let i = 0; i <= 4 ; i++){
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
const nodemailer = require('nodemailer');
const fs = require('fs');

let smtpConfig = {
    host: 'smtp.gmail.com',
    port: 465,
    secure: true, // use SSL
    auth: {
        user: 'theCinemaPortal@gmail.com',
        pass: 'theCinemaPortal04032010'
    }
};
let sender = nodemailer.createTransport(smtpConfig);

router.post('/confirm', function(req, res, next) {
    let fio = req.body.fio;
    let passport = req.body.passport;
    let email = req.body.email;
    console.log(req.session.data );

    //attrs, tickets_to, tickets_from, hostel
    connection.query("SELECT tickets.id, ticket_types.name, tickets.datetime, tickets.duration, tickets.price FROM unicorn.tickets inner join unicorn.ticket_types on tickets.id_type = ticket_types.id where tickets.id = ? ", [req.session.data.tickets_to],  function (error, ticket_to, fields) {
        connection.query("SELECT tickets.id, ticket_types.name, tickets.datetime, tickets.duration, tickets.price FROM unicorn.tickets inner join unicorn.ticket_types on tickets.id_type = ticket_types.id where tickets.id = ? ", [req.session.data.tickets_from],  function (error, ticket_back, fields) {
            // select hostels
            // connection.query("SELECT * FROM unicorn.rooms where id_hostel = (SELECT id from hotels where id_city = ? ) and price <= ? ", [cityTo, hotel_price],  function (error0, rooms, fields) {
            connection.query("SELECT rooms.id, hotels.name, hotels.marks, hotels.address, rooms.price FROM unicorn.rooms inner join hotels on hotels.id = rooms.id_hostel where hotels.id ? ", [req.session.data.hostel],  function (error0, room, fields) {
                // select attrs
                // connection.query("SELECT * FROM unicorn.attractions where id_city = ? and id_cat IN (" +attr+") and price <= ?", [cityTo, attr_price],  function (error1, attractions, fields) {
                connection.query("SELECT attractions.id, att_categories.name as 'category', attractions.duration, attractions.price, attractions.name FROM unicorn.attractions inner join att_categories on att_categories.id = attractions.id_cat where attractions.id IN (" +req.session.data.attrs+") ",  function (error1, attractions, fields) {
                    fs.readFile('views/book_letter2.html',{encoding: 'utf8'}, function (err, data) {
                        if(err){console.error(err); return;}

                        data = data.replace("@@ticket_to", 'from ' + req.session.data.cf + ', to ' + req.session.data.cf + ' at ' + ticket_to[0].datetime + ' during ' + ticket_to[0].duration + ', price is '+ ticket_to[0].price + '$')
                            .replace("@@user", fio)/*
                            .replace("@@date", req.session.sesInfo.dateTime)
                            .replace("@@hall", req.session.sesInfo.hallName)*/;
                        // console.log(data);
                        let mailOptions = {
                            from: '"Unicorn Trip"<theCinemaPortal@gmail.com>',
                            to: email,
                            subject: 'Booking | Unicorn Trip',
                            html: data
                        };
                        sender.sendMail(mailOptions, (err, info) => {
                            if(err){
                                console.log('ошибка отправки');
                                return console.error(err);
                            }
                            console.log('-Message ' + info.messageId + ' sent to ' + info.response);
                        });
                        res.send('ok');

                    });
                });


                // res.send(rooms);
            });


            // res.send(results0);
        });

    });



    // fs.readFile('views/book_letter2.html',{encoding: 'utf8'}, function (err, data) {
    //     if(err){console.error(err); return;}
    //
    //     data = data.replace("@@ticket_to", /*JSON.stringify(req.body.seats)*/ ticket_to)
    //         .replace("@@movie", req.session.sesInfo.movieName)
    //         .replace("@@date", req.session.sesInfo.dateTime)
    //         .replace("@@hall", req.session.sesInfo.hallName);
    //     // console.log(data);
    //     let mailOptions = {
    //         from: '"Кинотеатр PORTAL"<theCinemaPortal@gmail.com>',
    //         to: email,
    //         subject: 'Бронирование мест',
    //         html: data
    //     };
    //     sender.sendMail(mailOptions, (err, info) => {
    //         if(err){
    //             console.log('ошибка отправки');
    //             return console.error(err);
    //         }
    //         console.log('-Message ' + info.messageId + ' sent to ' + info.response);
    //     });
    //     res.send('ok');
    //
    // });

});

router.get('/accept', function(req, res, next) {
    let attrs = req.param('attrs');
    let tickets_to = req.param('tickets_to');
    let tickets_from = req.param('tickets_from');
    let hostel = req.param('hostel');
    let cf = req.param('cf');
    let ct = req.param('ct');
    req.session.data = {
        attrs, tickets_to, tickets_from, hostel, cf,ct
    };
    res.render('accept');
});
router.post('/process', function(req, res, next) {
    let price = parseFloat(req.body.price);
    let cityFrom = req.body.cityFrom;
    let cityTo = req.body.cityTo;
    let days = parseInt(req.body.days);
    let attr = req.body.attr;
    let date = req.body.date;
    let tickets_Price = 1/(3 + 2 * (days - 1)) * price;
    let tickets = null;

    // поиск подходящих билетов
    console.log(tickets_Price);
    //TODO если город родной - то только развалечения ищем

    // select tickets
    // connection.query("SELECT * FROM unicorn.tickets where id_from = ? and id_to = ? and tickets.datetime > ? and tickets.price <= ? ", [cityFrom, cityTo, date, tickets_Price],  function (error, tickets, fields) {
    connection.query("SELECT tickets.id, ticket_types.name, tickets.datetime, tickets.duration, tickets.price FROM unicorn.tickets inner join unicorn.ticket_types on tickets.id_type = ticket_types.id where id_from = ? and id_to = ? and tickets.datetime > ? and tickets.price <= ? ", [cityFrom, cityTo, date, tickets_Price/2],  function (error, tickets_to, fields) {
        if (error) {
            console.log( error);
            res.send('%TICKET-ERROR%');
            return;
        }
        if (tickets_to.length ===  0){
            res.send('%NO-TICKETS-TO%');
            return;
        }
        let hotel_price = ((price - tickets_Price) / 2) / days;
        let date_back = (date + "").split('-')[0] + '-'+(date + "").split('-')[1] +'-'+ (parseInt((date + "").split('-')[2]) + days);
        console.log(date_back);
        connection.query("SELECT tickets.id, ticket_types.name, tickets.datetime, tickets.duration, tickets.price FROM unicorn.tickets inner join unicorn.ticket_types on tickets.id_type = ticket_types.id where id_from = ? and id_to = ? and tickets.datetime >= ? and tickets.price <= ? ", [cityTo,cityFrom, date_back, tickets_Price/2],  function (error, tickets_back, fields) {
            if (error) {
                console.log( error);
                res.send('%TICKET-ERROR%');
                return;
            }
            if (tickets_back.length ===  0){
                res.send('%NO-TICKETS-BACK%');
                return;
            }
            // select hostels
            // connection.query("SELECT * FROM unicorn.rooms where id_hostel = (SELECT id from hotels where id_city = ? ) and price <= ? ", [cityTo, hotel_price],  function (error0, rooms, fields) {
            connection.query("SELECT rooms.id, hotels.name, hotels.marks, hotels.address, rooms.price FROM unicorn.rooms inner join hotels on hotels.id = rooms.id_hostel where id_hostel = (SELECT id from hotels where id_city = ? ) and price <= ? ", [cityTo, hotel_price],  function (error0, rooms, fields) {
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
                console.log('attr price');
                console.log(attr_price);
                // select attrs
                // connection.query("SELECT * FROM unicorn.attractions where id_city = ? and id_cat IN (" +attr+") and price <= ?", [cityTo, attr_price],  function (error1, attractions, fields) {
                connection.query("SELECT attractions.id, att_categories.name as 'category', attractions.duration, attractions.price, attractions.name FROM unicorn.attractions inner join att_categories on att_categories.id = attractions.id_cat where id_city = ? and id_cat IN (" +attr+") and price <= ? ", [cityTo, attr_price],  function (error1, attractions, fields) {
                    if (error1) {
                        console.log( error1);
                        res.send('%ATTR-ERROR%');
                        return;
                    }
                    if (attractions.length ===  0){
                        res.send('%NO-ATTR%');
                        return;
                    }

                    console.log('attractions');
                    console.log(attractions);
                    // let res = {tickets, rooms, attractions};
                    res.send(JSON.stringify({tickets_to, tickets_back, rooms, attractions}));
                    // let results =  combinator([ tickets, rooms, attractions ] );
                    // console.log('results');
                    // for(let i = 0; i < results.length; i++){
                    //     console.log(results[i]);
                    // }

                    // console.dir(results, 4);

                    // console.log(   combinator([ [ 1, 3, 5 ], [ "a", "b"], [ 2, 4 ] ] ).join("\n"));






                    /* А это, чтобы получить все варианты авто-номеров:
                     var digits = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ],
                     letters = [ "A", "B", "C", "E", "H", "K", "M", "O", "P", "T", "X", "Y" ];
                     combinator([ letters, digits, digits, digits, letters, letters ]);
                     */


                    // res.send(attractions);
                });


                // res.send(rooms);
            });


            // res.send(results0);
        });

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

function combinator(matrix){
    return matrix.reduceRight(function(combination, x){
        let result = [];
        x.forEach(function(a){
            combination.forEach(function(b){
                result.push( [ a ].concat( b ) );
            });
        });
        return result;
    });
}
module.exports = router;
