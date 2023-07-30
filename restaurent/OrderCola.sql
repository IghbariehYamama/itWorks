--הכנסת משקה קולה לשתיה קלה
declare @category varchar(10) = 'sandwiches', @meal varchar(10) = 'chicken',
@categoryID int, @descreption varchar(50) = 'vegetables, sauces..', @price decimal(5,2) = 33,
@start datetime = GETDATE(), @end datetime = GETDATE()+1, @mealID int
--בדיקה האם יש קטגוריה של שתיה קלה
--אם יש, צריך לקבל את הקוד של הקטגוריה
--אם אין, צריך להוסיף וגם לקבל את הקוד

select @categoryID = (select ID from categories where category_name = @category) 
--if categoryID is null then there's no drink
if @categoryID is null
--enter into categories and receive the ID
begin
insert into categories values(@category, 'it is good', 'no image available')
--this is a built in variable that receives the ID 
select @categoryID = @@identity
end
--בדיקה האם קיים קולה
if not exists (select ID from meals where meal_name = @meal)
--אין קולה ולכן מכניסים אותה ומקבלים את הקוד שלה
begin
insert into meals values(@categoryID, @meal, '0%', @descreption, 'no image')
select @mealID = @@identity
end
--יש קולה ולכן מקבלים את הקוד שלה
else
begin
select @mealID = (select ID from meals where meal_name = @meal)
end
--מכניסים את המחיר של הקולה
insert into prices values(@mealID, @price, @start, @end)

select * from categories
select * from meals
select * from prices
 
--check menu
--1st solution
select meals.meal_name as 'Food Name', meals.descreption as 'Descreption',
prices.price as 'Price' from meals, categories, prices where meals.category_ID = categories.ID and 
meals.ID = prices.mealID and (GETDATE() < prices.end_date) and (GETDATE() > prices.start_date)
--2nd solution with inner join
select meal_name as 'Food Name', meals.descreption as 'Descreption',
min(price) as 'Price' --minimum price
--relationship between meals and prices according to mealID
from meals inner join prices on meals.ID = prices.mealID
--the result, relationship with categories according to categoryID 
inner join categories on categories.ID = meals.category_ID 
--check if the current time is in between the start date and the end date
where GETDATE() between prices.start_date and prices.end_date 
--choose only drinks
and categories.category_name = 'drink'
--to integrate name and descreption
group by meal_name, meals.descreption 


--to order food from menu

