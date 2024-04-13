use test_memory;
go

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

