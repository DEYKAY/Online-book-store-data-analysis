# Online-book-store-data-analysis
# 📚 BookHub: Online Bookstore Data Analysis (SQL)

## 📊 Project Overview
This project performs a comprehensive analysis of an online bookstore database named **BookHub**. The goal is to extract actionable insights regarding inventory management, customer purchasing behavior and sales performance using SQL.

## 🛠️ Tech Stack & Skills
* **Database:** MySQL
* **SQL Techniques:** * **Data Definition (DDL):** Creating schemas with Primary & Foreign Keys.
    * **Joins:** Connecting Orders, Books and Customers.
    * **Aggregations:** Using `SUM`, `COUNT`, `AVG` with `GROUP BY`.
    * **Window Functions:** Implementing `DENSE_RANK()` for category-wise ranking.
    * **Common Table Expressions (CTEs):** Writing clean, modular queries.
    * **Data Cleaning:** Using `COALESCE` to handle null inventory values.

## 📁 Database Schema
The project uses three interconnected tables:
1. **Books**: Details about titles, authors, genres and stock levels.
2. **Customers**: Information on customer demographics and locations.
3. **Orders**: Transactional data linking customers and books.
4. import the data using table data import or use copy keyword and past file path in postgrade SQL


## 💡 Key Business Questions Answered
* **Inventory:** Which books have the lowest stock and need replenishing?
* **Sales:** What is the total revenue and which authors are top-sellers?
* **Customers:** Who are the high-value customers and where are they located?
* **Advanced Insights:** What is the most expensive book in every genre?

## 🚀 How to Use
1. Clone this repository.
2. Run the `BookHub.sql` script in your SQL editor (MySQL Workbench, pgAdmin, etc.).

Dinesh choudhary 
LinkedIn - https://www.linkedin.com/in/dinesh-bana-47b120263/
