-- Customers Table
drop database if exists Ecommerce_sales_analytics_system;
create database Ecommerce_sales_analytics_system;
use Ecommerce_sales_analytics_system;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    city TEXT,
    signup_date DATE
);

-- Products Table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

-- Orders Table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    payment_method TEXT,
    amount REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SELECT 
    p.product_name,
    SUM(oi.quantity) as total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
SELECT 
    c.customer_id,
    c.name,
    SUM(p.amount) as lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id;
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Connect to SQLite Database
conn = sqlite3.connect("ecommerce.db")
cursor = conn.cursor()

# -------------------------------
# Insert Sample Data
# -------------------------------

customers = [
    (1, "Alice", "alice@gmail.com", "New York", "2023-01-10"),
    (2, "Bob", "bob@gmail.com", "Chicago", "2023-02-15"),
    (3, "Charlie", "charlie@gmail.com", "Los Angeles", "2023-03-20")
]

products = [
    (1, "Laptop", "Electronics", 1000),
    (2, "Phone", "Electronics", 600),
    (3, "Shoes", "Fashion", 120),
    (4, "Watch", "Fashion", 250)
]

orders = [
    (1, 1, "2023-05-01"),
    (2, 2, "2023-05-03"),
    (3, 1, "2023-06-10"),
    (4, 3, "2023-06-15")
]

order_items = [
    (1, 1, 1, 1),
    (2, 1, 3, 2),
    (3, 2, 2, 1),
    (4, 3, 4, 1),
    (5, 4, 1, 1)
]

payments = [
    (1, 1, "Credit Card", 1240),
    (2, 2, "PayPal", 600),
    (3, 3, "Credit Card", 250),
    (4, 4, "Debit Card", 1000)
]

cursor.executemany("INSERT INTO customers VALUES (?, ?, ?, ?, ?)", customers)
cursor.executemany("INSERT INTO products VALUES (?, ?, ?, ?)", products)
cursor.executemany("INSERT INTO orders VALUES (?, ?, ?)", orders)
cursor.executemany("INSERT INTO order_items VALUES (?, ?, ?, ?)", order_items)
cursor.executemany("INSERT INTO payments VALUES (?, ?, ?, ?)", payments)

conn.commit()

# -------------------------------
# Advanced SQL Query
# -------------------------------

query = """
SELECT 
    c.name,
    SUM(p.amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name
ORDER BY total_spent DESC
"""

df = pd.read_sql_query(query, conn)
print(df)

# -------------------------------
# Visualization
# -------------------------------

plt.figure(figsize=(8,5))
sns.barplot(x="name", y="total_spent", data=df)
plt.title("Total Spending by Customer")
plt.show()

conn.close()