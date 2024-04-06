CREATE VIEW `Order_Content` AS 
select m1.order_id, m2.mealsDrinksName, m3.mdTypeName
from Order_has_MealsDrinks as m1 , MealsDrinks as m2, MealsDrinksDetail as m3
Where m1.mealsDrinks_id = m2.mealsDrinks_id
and m2.mdType_id = m3.mdType_id;


CREATE VIEW `DeliverymanNumberOfOrders` AS 
Select d.deliveryman_id, d.firstName, d.lastName,  Count(o.order_id) as NumberofOrders
from Deliveryman as d, `Order` as o
where d.deliveryman_id = o.deliveryman_id
Group by d.deliveryman_id;

-- Queries

-- Find all ingredient names in Meals and drinks
Select m.mealsDrinks_id, m1.mealsDrinksName, m2.ingredientName
From MealsDrinks_has_Ingredients as m, MealsDrinks as m1, ingredients as m2
Where m.mealsDrinks_id = m1.mealsDrinks_id and m.ingredient_id = m2.ingredient_id
order by m.mealsDrinks_id;

-- Find those customers' names and emails who have done a payment more than one time and it was 
-- more than 5000 AMD 
 Select c.customer_id, c.firstName, c.lastName, c.email
 From Customer as c Join Payment as p
 on c.customer_id = p.customer_id
 where p.amount > 5000 and currency like 'AMD'
 Group by c.customer_id
 having count(p.customer_id) > 1;
 
-- Find the best restaurants by their rating 
select r.restaurantName, count(rr.restaurant_id) as TimesRated5
from Restaurant as r Join RestaurantRating as rr
using (restaurant_id)
Where rr.rating = 5
Group by r.restaurant_id
order by TimesRated5 desc;

-- Find the worst restaurants by their rating 
select r.restaurantName, count(rr.restaurant_id) as TimesRated1
from Restaurant as r Join RestaurantRating as rr
using (restaurant_id)
Where rr.rating = 1
Group by r.restaurant_id
order by TimesRated1 asc;

-- Find those customers' names and emails who haven't done any orders yet

select c.firstName, c.lastName, c.email
from Customer as c  Left Join `Order` as o
using(customer_id)
where o.order_id is Null;

-- Find those meals and drinks and name of their type that haven't been ordered
select m.*, m2.mdTypeName
From Order_has_MealsDrinks as om 
right join MealsDrinks as m on om.mealsDrinks_id = m.mealsDrinks_id
Join MealsDrinksDetail  as m2  on m.mdType_id = m2.mdType_id
where om.order_id is null;


-- Count How much each of the restaurants earned in AMD
Select r.restaurantName, sum(p.amount) as income_AMD
From Restaurant_has_Order ro join Restaurant r using(restaurant_id)
join `Order` o using (order_id)
join payment p using(customer_id)
Where p.currency = 'AMD' and  o.orderStatus <> "cancelled"
Group by r.restaurant_id;


-- We want to find those customers whose password is less than 10 digits and send them mails
-- to update their passwords get the needed data

select c.email, c.password
from Customer as c
where c.password not in
(select password
from Customer 
where password like '__________%') ;

   -- or this query can be written in more simple manner
select c.email, c.password
from Customer as c
where c.password not like '__________%';

