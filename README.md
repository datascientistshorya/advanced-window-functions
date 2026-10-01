# Advanced Window Functions & Business Analysis

## Author

**Shorya Dev Bisht**

LinkedIn: https://www.linkedin.com/in/shorya-bisht-a20144349/

This project contains a structured set of MySQL exercises focused on applying window functions to practical business-analysis problems.

The exercises move beyond basic aggregation and JOINs into customer-level benchmarking, revenue ranking, contribution analysis, period-over-period comparison, product/category analysis, and customer segmentation.

The primary objective is to develop the ability to transform transactional data into business insights using analytical SQL.

## Objectives

The exercises are designed to build practical proficiency in:

* Ranking customers, orders, products, and categories
* Comparing individual orders with customer-level benchmarks
* Calculating customer contribution percentages
* Measuring product and category revenue performance
* Performing previous-order and order-to-order analysis
* Calculating growth rates using previous-period values
* Identifying top-performing products within categories
* Segmenting customers according to revenue contribution
* Combining window functions with CTEs, JOINs, aggregations, and CASE logic
* Writing SQL that answers realistic business questions

## Business Analysis Focus

The exercises use an online-store dataset containing customers, orders, and products.

The analysis focuses on questions such as:

* Which orders are the highest value for each customer?
* How much does each order contribute to a customer's total value?
* Which products generate the most revenue?
* Which categories contribute the most to overall revenue?
* Is an individual order above or below a customer's normal order value?
* How has a customer's order value changed compared with their previous order?
* Which product is the highest-revenue product within each category?
* Which customers belong to high-, medium-, and low-value segments?

## SQL Techniques Used

### Window Functions

* `RANK() OVER()`
* `LAG() OVER()`
* `NTILE() OVER()`
* `SUM() OVER()`
* `AVG() OVER()`
* `MAX() OVER()`

### Window Concepts

* `PARTITION BY`
* `ORDER BY` inside window functions
* Customer-level partitions
* Category-level partitions
* Overall window calculations
* Previous-row analysis

### Aggregation

* `SUM()`
* `AVG()`
* `MAX()`
* `GROUP BY`
* Revenue calculations
* Customer-level aggregation
* Product-level aggregation
* Category-level aggregation

### CTEs

Common Table Expressions were used to break complex analytical problems into logical stages.

Examples include:

* Creating customer-level totals before ranking
* Creating product-level revenue before ranking
* Creating category-level revenue before calculating overall share
* Separating ranking and segmentation logic into multiple analytical stages

### JOINs

The exercises use `INNER JOIN` to combine:

* `customers`
* `orders`
* `products`

This allows transactional data to be connected with customer and product dimensions for business analysis.

### CASE Expressions

`CASE` was used to convert analytical results into meaningful business classifications, particularly for customer segmentation.

## Key Analytical Concepts Practiced

### Customer Order Ranking

Orders are ranked within each customer according to order value.

This demonstrates the difference between:

```sql
RANK() OVER (
    PARTITION BY customer_id
    ORDER BY amount DESC
)
```

and a global ranking across all orders.

### Customer Contribution

Each order is compared with the customer's total order value to determine its percentage contribution.

```text
Order Contribution =
Order Amount / Customer Total × 100
```

### Revenue Ranking

Products are aggregated first and then ranked according to total revenue.

This separates:

1. Transaction-level data
2. Product-level aggregation
3. Revenue ranking

### Revenue Share

Category revenue is compared with overall revenue to determine each category's contribution to the business.

```text
Revenue Share =
Category Revenue / Overall Revenue × 100
```

### Customer Benchmarking

Individual orders are compared against the customer's average order value.

```text
Difference from Average =
Order Amount - Customer Average Order Value
```

This provides a simple way to identify unusually large or small purchases relative to a customer's normal behavior.

### Previous-Order Analysis

`LAG()` is used to retrieve the previous order amount for each customer.

This creates the foundation for:

* Order-to-order comparison
* Customer purchasing behavior analysis
* Growth calculations
* Sequential transaction analysis

### Growth Analysis

Order growth is calculated relative to the customer's previous order.

```text
Growth % =
(Current Order - Previous Order)
/
Previous Order × 100
```

The first order naturally produces `NULL` because there is no previous order to compare against.

### Within-Category Ranking

Products are ranked independently inside each category rather than across the entire product catalog.

This is an important analytical distinction because the business question changes from:

> Which product is the highest revenue product overall?

to:

> Which product is the highest revenue product within its category?

### Customer Segmentation

Customers are ranked by total order value and divided into four groups using `NTILE(4)`.

The resulting groups are interpreted as:

* High Value — top 25%
* Medium Value — middle 50%
* Low Value — bottom 25%

This demonstrates how window functions can transform numerical rankings into actionable customer segments.

## Techniques Mastered

Through these exercises, the following analytical SQL techniques were practiced:

* Window-function ranking
* Partitioned ranking
* Customer-level benchmarking
* Revenue contribution analysis
* Overall share calculations
* Previous-row analysis
* Period-over-period growth
* Product/category ranking
* Percentile-style segmentation
* Multi-stage CTE analysis
* Window functions combined with aggregation
* Window functions combined with CASE
* JOIN + aggregation + window-function workflows
* Business-oriented SQL problem solving

## Tools

* MySQL
* MySQL Workbench
* SQL
* GitHub

## Dataset Structure

The exercises use three primary tables:

### customers

```text
customer_id
customer_name
city
```

### orders

```text
order_id
customer_id
product_id
amount
status
order_date
```

### products

```text
product_id
product_name
category
price
```

## Analytical Perspective

The purpose of these exercises is not only to write syntactically correct SQL, but to understand how SQL can answer business questions.

The workflow generally follows:

```text
Raw Transactions
       ↓
Aggregation
       ↓
Business Metric
       ↓
Window Analysis
       ↓
Comparison / Ranking
       ↓
Segmentation
       ↓
Business Insight
```

This approach helps bridge the gap between SQL syntax and practical data-analysis thinking.

## Author

**Shorya Dev Bisht**

LinkedIn: https://www.linkedin.com/in/shorya-bisht-a20144349/

## Project Focus

**Advanced SQL | Window Functions | Business Analytics | Customer Analysis | Revenue Analytics | MySQL**
