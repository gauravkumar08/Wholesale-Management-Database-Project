const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));

// Database Connection
const db = new sqlite3.Database('./wholesale.db', (err) => {
    if (err) {
        console.error(err.message);
    }
    console.log('Connected to the wholesale database.');
});

// Routes
app.get('/', (req, res) => {
    db.all('SELECT * FROM Products', [], (err, products) => {
        if (err) {
            throw err;
        }
        res.render('index', { products });
    });
});

app.post('/add_product', (req, res) => {
    const { product_name, category, quantity, cost_price, selling_price } = req.body;
    db.run('INSERT INTO Products (ProductName, Category, Quantity, CostPrice, SellingPrice) VALUES (?, ?, ?, ?, ?)', [product_name, category, quantity, cost_price, selling_price], function(err) {
        if (err) {
            return console.error(err.message);
        }
        console.log(`A row has been inserted with rowid ${this.lastID}`);
        res.redirect('/');
    });
});

app.post('/delete_product/:id', (req, res) => {
    const productId = req.params.id;
    db.run('DELETE FROM Products WHERE ProductID = ?', productId, (err) => {
        if (err) {
            return console.error(err.message);
        }
        console.log(`Product with ID ${productId} deleted.`);
        res.redirect('/');
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
