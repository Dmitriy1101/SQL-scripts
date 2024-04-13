use test_memory;
go

--Заполняем спецификацию
insert into material_specification(quantity, material_id, specification_id)
values 
(50, (select id from dbo.materials where name = 'Кирпич'), (select id from get_spec_by_ord_name('Мангал'))),
(10, (select id from dbo.materials where name = 'Плитка'), (select id from get_spec_by_ord_name('Мангал'))),
(50, (select id from dbo.materials where name = 'Цемент'), (select id from get_spec_by_ord_name('Мангал'))),
(30, (select id from dbo.materials where name = 'Песок'), (select id from get_spec_by_ord_name('Мангал'))),
(9, (select id from dbo.materials where name = 'Арматура'), (select id from get_spec_by_ord_name('Мангал'))),
(2500, (select id from dbo.materials where name = 'Кирпич'), (select id from get_spec_by_ord_name('Кирпичьный забор'))),
(500, (select id from dbo.materials where name = 'Цемент'), (select id from get_spec_by_ord_name('Кирпичьный забор'))),
(300, (select id from dbo.materials where name = 'Песок'), (select id from get_spec_by_ord_name('Кирпичьный забор'))),
(30, (select id from dbo.materials where name = 'Арматура'), (select id from get_spec_by_ord_name('Кирпичьный забор')));
go

--Запрос для теста перерасчета стоимости заказа
--update material_specification
--set quantity = 45 
--where  material_id =  (select id from dbo.materials where name = 'Кирпич') and specification_id = (select id from get_spec_by_ord_name('Мангал'));