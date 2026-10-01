/*Q1 — Customer Order Ranking
For each customer, rank their orders by amount from highest to lowest.
Return:
customer_id
order_id
amount
order_rank*/
select customer_id,order_id,amount,
rank() over(partition by customer_id order by amount desc) as order_rank
from orders;

/*Q2 — Highest-Value Order per Customer
Find the highest-value order for every customer.
Return:
customer_id
order_id
amount
Use a window function to identify the highest-value order.*/

with order_data as(
select customer_id,order_id, amount,
 max(amount)over (partition by customer_id ) as max_order
from orders
)
select customer_id,order_id, amount from order_data
where amount=max_order;

/*Q3 — Customer Order Contribution
For every order, calculate:
•	The customer's total order value 
•	The percentage that the current order contributes to that customer's total 
Return:
customer_id
order_id
amount
customer_total
order_contribution_pct
Example:
If a customer has orders of ₹1,000, ₹2,000 and ₹7,000:
customer_total = ₹10,000
The ₹2,000 order contributes:20%*/
with cust_data as(
select customer_id,order_id, amount,
sum(amount) over(partition by customer_id) as customer_total
-- (amount/customer_total)*100 as contribution
from orders)
select*, (amount/customer_total)*100 as contribution
from cust_data;

/*Q4 — Product Revenue Ranking
Calculate total revenue for every product and rank products from highest to lowest revenue.
Return:
product_id
product_name
total_revenue
revenue_rank*/
with rank_rev as(
select p.product_id,p.product_name,sum(o.amount)as total_rev
from products p inner join orders o 
on p.product_id=o.product_id
group by p.product_id,p.product_name
)
select *,
rank() over(order by total_rev desc) as revenue_rank
from rank_rev;

/*Q5 — Category Revenue Share
Calculate each category's:
•	Total revenue 
•	Overall revenue 
•	Percentage contribution to overall revenue 
Return:
category
category_revenue
overall_revenue
revenue_share_pct*/
with cat_data as(
	select p.category,sum(o.amount) as cat_rev    
    from products p inner join orders o 
    on p.product_id=o.product_id
    group by p.category
)
select * ,
sum(cat_rev) over()as total_rev,
round(
cat_rev/sum(cat_rev) over()*100,2) as revenue_share_pct
from cat_data ;

/*Q6 — Customer Order vs Customer Average
For every order, compare the order amount with that customer's average order value.
Return:
customer_id
order_id
amount
customer_avg_order
difference_from_avg
Where:
difference_from_avg =order amount - customer average order amount
This should help answer: Was this particular order above or below the customer's normal order value?*/
select customer_id,order_id,amount,
avg(amount) over(partition by customer_id) as avg_amount,
round(amount-avg(amount) over(partition by customer_id),2) as difference_from_avg
from orders;

/*Q7 — Previous Order Comparison
For each customer's order, show the previous order amount.
Return:
customer_id
order_id
order_date
amount
previous_order_amount
Use:
LAG()
Orders should be ordered chronologically for each customer.*/
select customer_id,order_id,order_date, amount,
lag(amount) over(partition by customer_id order by order_date) as prev_amount
from orders;

/*Q8 — Order-to-Order Growth
For every customer's order, calculate the percentage change from their previous order.
Return:
customer_id
order_id
order_date
amount
previous_order_amount
growth_pct Formula: (amount - previous_order_amount)/previous_order_amount * 100
For the customer's first order, return NULL for the growth percentage.*/

select customer_id,order_id,amount,
lag(amount) over(partition by customer_id order by order_date) as prev_amount,
(amount-lag(amount) over(partition by customer_id order by order_date))/lag(amount) over(partition by customer_id order by order_date)*100 as growth_rate
from orders;

/*Q9 — Top Product Within Each Category
Find the highest-revenue product within every category.
Return:
category
product_id
product_name
product_revenue
category_rank
Use a window function to rank products within their category.
Important distinction:
We are not looking for the highest-revenue product overall.
We need the highest-revenue product inside each category*/
with cat_data as(
select p.category,p.product_name,
sum(o.amount) as cat_rev
from products p inner join orders o
on p.product_id=o.product_id
group by  p.category,p.product_id,p.product_name
),
rank_data as(
select*,
rank() over(partition by category order by cat_rev desc) as rev_rank
from cat_data
)
select* from rank_data
where rev_rank=1; 

/*Calculate each customer's total order value and rank all customers from highest to lowest.
Then classify them based on their rank:
Top 25%       → High Value
Middle 50%    → Medium Value
Bottom 25%    → Low Value
Return:
customer_id
customer_total
customer_rank
customer_percentile
customer_segment*/
WITH customer_data AS (
    SELECT
        customer_id,
        SUM(amount) AS total_order
    FROM orders
    GROUP BY customer_id
),
ranked_customer AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_order DESC
        ) AS customer_rank
    FROM customer_data
),
segmented_customer AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY total_order DESC
        ) AS percentile
    FROM ranked_customer
)
SELECT
    *,
    CASE
        WHEN percentile = 1 THEN 'High'
        WHEN percentile IN (2,3) THEN 'Medium'
        ELSE 'Low'
    END AS segment
FROM segmented_customer;