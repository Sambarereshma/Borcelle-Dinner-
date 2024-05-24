use dannys_dinner;
select * from sales;     

1.What is the total amount each customer spent at the restaurant?

select sales.customer_id,sum(menu.price) as Total_spend
from sales 
join members on sales.customer_id = members.customer_id
join menu on menu.product_id = sales.product_id
group by sales.customer_id
order by customer_id 

2.How many days has each customer visited the restaurant?

select customer_id, count(distinct(order_date))as days_of_visiting 
from sales
group by customer_id
order by customer_id 

3. What was the first item from the menu purchased by each customer?

select sales.customer_id, sales.product_id, menu.product_name,sales.order_date
from sales join menu on sales.product_id = menu.product_id
where sales.order_date = (select min(order_date) from sales where customer_id = sales.customer_id)
order by sales.product_id 

4.What is the most purchased item on the menu and how many times was it purchased by all custome
  
select count(sales.product_id) as purchase_count,menu.product_name,menu.product_id from sales 
join menu on menu.product_id = sales.product_id
group by menu.product_name,menu.product_id,menu.price
order by purchase_count desc 
limit 1

5.Which item was the most popular for each customer?

select sales.customer_id,menu.product_name,count(sales.product_id) as times_of_eating from sales
join menu on sales.product_id = menu.product_id
where sales.product_id >= 2
group by sales.customer_id,menu.product_id 
order by customer_id, times_of_eating desc


6.Which item was purchased first by the customer after they became a member?

select sales.customer_id,sales.product_id,menu.product_name,sales.order_date as order_after_member
from sales
join menu on sales.product_id = menu.product_id
join members on sales.customer_id = members.customer_id
where sales.order_date >=  members.join_date+1
group by sales.customer_id,sales.order_date,menu.product_id
order by sales.order_date , sales.customer_id desc
limit 2

7.Which item was purchased just before the customer became a member?

select sales.customer_id,menu.product_name as item_purchase_before_member,sales.order_date as date_before_member  
from sales
join menu on sales.product_id = menu.product_id
join members on sales.customer_id = members.customer_id
where sales.order_date <= members.join_date -1
group by sales.customer_id ,menu.product_name,sales.order_date 
select * from sales;

8.What is the total items and amount spent for each member before they became a member?

select sales.customer_id,count(sales.product_id),sum(menu.price) as amount_spend
from sales
join menu on sales.product_id = menu.product_id
join members on sales.customer_id = members.customer_id
where sales.order_date <= members.join_date -1
group by sales.customer_id

