-- Create Database
CREATE DATABASE	BookHub
USE Bookhub

--  Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    C_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
-- imported the data csv files using table data import wizard
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fantasy" genre:
select * from books
where genre = 'fantasy'

-- 2) Find books published after the year 2000:
Select * from books 
where published_year >2000

-- 3) List all customers from the India
SELECT * FROM customers
WHERE country = 'india'

-- 4) Show orders placed in jan 2024:
Select * from orders
where order_date between '2024-01-01' and '2024-01-30'

-- 5) Retrieve the total stock of books available:
Select sum(stock) as total_stock
from books

-- 6) Find the details of the most expensive book:
Select * from books
order by price desc
limit 1

-- 7) Show all customers who ordered more than 5 quantity of a book:
Select * from orders
where quantity > 5

-- 8) Retrieve all orders where the total amount exceeds $20:
Select * from orders
where total_amount > 20
order by total_amount asc

-- 9) List all genres available in the Books table:
Select Distinct(genre) as total_genre
from books

-- 10) Find the book with the lowest stock:
Select * from books 
order by stock asc
limit 1

-- Calculate the total revenue generated from all orders:
Select sum(total_amount) as Revenue from orders

-- Advance queries : 
-- Retrieve the total number of books sold for each genre:
Select b.genre, sum(o.quantity) as total_book_sold
from orders o
join books b
on b.book_id = o.book_id
group by b.genre order by total_book_sold desc

-- 2) Find the average price of books in the "Sciene fiction" genre:

Select avg(price) as average 
from books where genre = 'science fiction'

-- 3) List customers who have placed at least 2 orders:
Select o.customer_id, c.c_name, count(o.order_id) as ordercount
from orders o
join customers  c on o.customer_id = c.customer_id
group by customer_id
having count(order_id) >= 2

-- 4) Find the most frequently ordered books:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
having COUNT(o.order_id) > 3  -- max oder count is 4 so value filtered out greater then 3
ORDER BY ORDER_COUNT DESC

-- 5) Identify the most expensive book in each genre  :
With RankedBooks AS (
    Select 
        book_id, title, genre, price,
        dense_rank() OVER(partition by genre order by price desc) as price_rank       -- using window function
    From books
)
Select 
    genre, title, price
From RankedBooks
Where price_rank = 1;


-- 6) Retrieve the total quantity of books sold by each author:
Select b.author, SUM(o.quantity) AS Total_Books_Sold
From orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author order by Total_Books_Sold desc ;

-- 7) List the cities where customers who spent over $100 are located: 
Select distinct c.city, o.total_amount from orders o
Join customers c on c.customer_id = o.customer_id
Where o.total_amount > 100

-- 8) Find the customer who spent the most on orders:
Select o.customer_id, c.c_name, sum(o.total_amount) as total_spent
from orders o 
join customers c on c.customer_id = o.customer_id
group by c.customer_id, c.c_name
order by total_spent desc
limit 1

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;
