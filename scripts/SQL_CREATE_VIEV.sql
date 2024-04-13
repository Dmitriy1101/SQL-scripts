use test_memory;
go

--Создаём представление
create view orders_info 
as
	select o.name as 'Заказ', 
	o.price as 'Цена заказа',
	o.description as 'Описание заказа',
	ms.quantity  as 'Количество материала',
	m.name as 'Материал',
	m.price as 'Цена', 
	m.description as 'Коментарий'
	from dbo.orders as o
	join dbo.specification as s on o.id = s.order_id
	left join dbo.material_specification as ms on s.id = ms.specification_id
	left join dbo.materials as m on m.id = ms.material_id;