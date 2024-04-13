use test_memory;
go

--Скрипт для создания структуры БД test и заполнения таблиц тестовыми данными

--Такая структура создана для дальнейшей практики исправления столбцов.
--Работники выполняющие заказы
create table workers(
	id int identity (1,1) not null, 
	constraint PK_worker_id primary key clustered(id),
	name char(20) not null,
	surname char(20) not null,
	patronymic char(20) not null,
	birthdate datetime not null,
	registrations datetime default getdate(),
	is_active bit default 1
);

--Заказы 
create table orders(
	id int identity (1,1) not null,
	constraint PK_order_id primary key clustered(id), 
	name char(20),
	price smallmoney,
	description varchar(200),
	worker int,
	constraint FK_worker_id foreign key (worker) references workers(id) 
	on delete no action
	on update cascade
);

--Материалы их цены и описание
create table materials(
	id int identity (1,1) not null,
	constraint PK_materials_id primary key clustered(id), 
	name char(20) not null,
	price smallmoney not null,
	description varchar(200)
);

--Спецификация, позже можем добавить разработчика, чертёж или гост
create table specification(
	id int identity (1,1) not null,
	constraint PK_specification_id primary key clustered(id), 
	order_id int not null unique,
	constraint FK_order_id foreign key(order_id) references orders(id) 
	on delete cascade
	on update cascade
);

--Связываем материялы, их количество с спецификаиями
create table material_specification(
	quantity smallint,
	material_id int not null foreign key references materials(id),
	specification_id int not null foreign key references specification(id),
	constraint PK_material_specification_id primary key clustered(material_id, specification_id)
);
go

--Правки в таблицах
--Добавляем вычисляемый столбец и сразу расчитываем
alter table workers add infofield  as ('s'+ convert(varchar(10), id)+ ' ' + name) persisted;
go

--Имя заказа не нолевое
alter table dbo.orders 
alter column name char(20) not null;
go

--Имя заказа  уникально
alter table orders 
add constraint UC_ord_name unique (name);
go

--Имя материала уникально
alter table materials 
add constraint UC_mat_name unique (name);
go

--Делаем комбинацию полей уникальной
alter table workers 
add constraint UC_wor_nspd unique (name, surname, patronymic, birthdate);
go

--Функции
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

--Тригеры
--При создании заказа будет создаваться спецификация
create trigger create_order_specification
on dbo.orders
after insert
as
begin
	select id into #tablein from inserted;
	declare @iter int = (select count(id) from #tablein);
	declare @i int;
	while @iter > 0
	begin
		set @i = (
		select distinct first_value(id) over (order by id asc) from #tablein
		);
		insert into dbo.specification (order_id)
		values (@i);
		delete from #tablein where id = @i;
		set @iter = @iter -1;
	end;
end;
go

--При добавлении/изменении матерьяла в спецификации перерасчитывается стоимость заказа
create trigger create_order_price
on dbo.material_specification
after insert, update
as
begin
	select distinct null i, specification_id into #tablein from inserted;
	declare @iter int = (select count(specification_id) from #tablein);
	while @iter > 0
	begin
		update #tablein set i = 1 where specification_id = (
		select distinct first_value(specification_id) over (order by specification_id asc) from #tablein
		);
		update dbo.orders
		set price = dbo.get_ord_price_by_spec_id((select specification_id from #tablein where i = 1))
		where id = (select id from dbo.get_ord_by_spec_id((select specification_id from #tablein where i = 1)))
		delete from #tablein where i = 1;
		set @iter = @iter -1;
	end;
end;
go

--Заполнение таблиц
--Заполняем материаля
insert into materials (name, price, description)
values ('Кирпич', 25, 'цена за шт'),
('Плитка', 100, 'цена за шт'),
('Цемент', 70, 'цена за кг'),
('Песок', 50, 'цена за кг'),
('Арматура', 250, 'цена за шт');
go

--Заполняем заказы
insert into orders(name, description)
values 
('Мангал', null),
('Кирпичьный забор', 'Забор на дачном участке'),
('Кирпичный дом','Пригород'),
('Котедж Космос 2А','Срочный'),
('Дорога к дому', 'Срочный'),
('Котедж Речной 8Б','Срочный'),
('Остановка "Поворот"', 'Срочный');
go

--Заполняем работников
insert into workers (name, surname, patronymic, birthdate)
values 
('Graham', 'Riggs', 'Griffin', '19920409'),
('Burke', 'Bray', 'Emerson', '19991015'),
('Guy', 'Merrill', 'Octavius', '19810721'),
('Brock', 'Small', 'Alfonso', '19860427'),
('Quin', 'Rodriquez', 'Amir', '19960321'),
('Никитос', 'Васин', 'Васильевич', '21010201'),
('Никитос', 'Васин', 'Васильевич', '22010201'),
('Никитосик', 'Васин', 'Васильевич', '21010201'),
('Никитос', 'Васиннюк', 'Васильевич', '21010201'),
('Никитос', 'Васин', 'Васьевич', '21010201'),
('Семен', 'Семёнов', 'Семёнович', '19920409'),
('Пётр', 'Петров', 'Петрович', '19991015'),
('Иванов', 'Иван', 'Иванович', '19810721'),
('Олег', 'Олегов', 'Олегович', '19860427'),
('Игорь', 'Игорев', 'Игоревич', '19960321'),
('Вася', 'Чёткий', 'Перец', '20000922');
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
--go

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
go