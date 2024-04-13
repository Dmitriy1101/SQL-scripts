use test_memory;
go

--Получаем id спецификации по имени заказа
create function dbo.get_spec_by_ord_name (@name char(20))
returns table
as
return
(
	select s.id from dbo.specification as s
	join dbo.orders as o on o.id = s.order_id
	where o.name = @name
);
go

--Получаем заказ по id спецификации
create function dbo.get_ord_by_spec_id (@specif_id int)
returns table
as
return
(
	select o.id, o.name, o.price from dbo.orders as o 
	left join dbo.specification as s on o.id = s.order_id 
	where s.id = @specif_id
);
go

--Вычисляем стоимость заказа имея id спецификации
create function dbo.get_ord_price_by_spec_id (@specif_id int)
returns smallmoney
with execute as caller
as
begin
	declare @price smallmoney;
	set @price = (select sum(ms.quantity * m.price) as pr
	from dbo.material_specification as ms
	join dbo.materials as m on  ms.material_id = m.id
	where ms.specification_id = @specif_id);
return @price;
end;
go