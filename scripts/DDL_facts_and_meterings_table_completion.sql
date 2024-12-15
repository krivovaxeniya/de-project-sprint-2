/* Шаг 2 */

/* Заполнение таблиц-измерений d_craftsman, d_product, d_customer из новых источников */
INSERT INTO dwh.d_craftsman (craftsman_name , craftsman_address , craftsman_birthday , craftsman_email, load_dttm)
select
craftsman_name , 
craftsman_address , 
craftsman_birthday , 
craftsman_email,
NOW()
from external_source.craft_products_orders
;
INSERT INTO dwh.d_product (product_name , product_description , product_type , product_price, load_dttm)
select
product_name , 
product_description , 
product_type , 
product_price ,
NOW()
from external_source.craft_products_orders
;
INSERT INTO dwh.d_customer (customer_name , customer_address , customer_birthday , customer_email, load_dttm)
select
customer_name , 
customer_address , 
customer_birthday , 
customer_email,
NOW()
from external_source.customers;

/* Заполнение таблицы фактов f_order из новых источников */
INSERT INTO dwh.f_order (product_id , craftsman_id, customer_id , order_created_date, order_completion_date , order_status, load_dttm)
select
dp.product_id,
cr.craftsman_id,
dc.customer_id,
cpo.order_created_date,
cpo.order_completion_date,
cpo.order_status,
dp.load_dttm
FROM external_source.craft_products_orders cpo
join external_source.customers ec on ec.customer_id = cpo.customer_id
join dwh.d_craftsman cr on cr.craftsman_name = cpo.craftsman_name and cr.craftsman_address = cpo.craftsman_address and cr.craftsman_birthday = cpo.craftsman_birthday 
							and cr.craftsman_email = cpo.craftsman_email 
join dwh.d_product dp on dp.product_name = cpo.product_name and dp.product_description = cpo.product_description and dp.product_type = cpo.product_type 
						and dp.product_price = cpo.product_price 
join dwh.d_customer dc on dc.customer_name = ec.customer_name and dc.customer_address = ec.customer_address and dc.customer_birthday = ec.customer_birthday 
						and dc.customer_email = ec.customer_email 