use test;
go

--1 òàáëèöû
--IF OBJECT_ID('dbo.Basket', 'U') IS NOT NULL
DROP TABLE IF EXISTS dbo.Basket;
go

--IF OBJECT_ID('dbo.SKU', 'U') IS NOT NULL
DROP TABLE IF EXISTS dbo.SKU;
go

--IF OBJECT_ID('dbo.Family', 'U') IS NOT NULL
DROP TABLE IF EXISTS dbo.Family;
go

create table dbo.SKU(
	ID int identity (1,1), 
	constraint PK_SKU_id primary key clustered(id),
	Code as ('s'+ convert(varchar(10), id)) unique,
	Name varchar(255)
	);

create table dbo.Family(
	ID int identity (1,1), 
	constraint PK_Family_id primary key clustered(id),
	SurName varchar(255) unique,
	BudgetValue money
	);

create table dbo.Basket(
	ID int identity (1,1), 
	constraint PK_Basket_id primary key clustered(id),
	ID_SKU int,
	constraint FK_SKU_id foreign key (ID_SKU) references SKU(ID),
	ID_Family int,
	constraint FK_Family_id foreign key (ID_Family) references Family(ID),
	Quantity smallint,
	constraint CHK_Basket_Quantity check(Quantity > 0),
	Value decimal(18, 2),
	constraint CHK_Basket_Value check(Value > 0.00),
	PurchaseDate datetime default getdate(),
	DiscountValue decimal(3, 2) default 0.00
	);
go

--2 ïðîöåäóðà
DROP PROCEDURE IF EXISTS dbo.usp_MakeFamilyPurchase;
go

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
(
    @FamilySurName varchar(255)
)
AS
BEGIN
	declare @id int
	set @id = (select f.id from dbo.Family f where f.SurName = @FamilySurName)
	if @id = null
		raiserror ('FamilySurName value not found',16,1);
	update dbo.Family
    set BudgetValue = (BudgetValue - (
	select sum(b.value) from dbo.Basket b 
	where b.ID_Family = @id
	))
	where ID = @id
END
go

--3 ïðåäñòàâëåíèå
DROP VIEW IF EXISTS dbo.vw_SKUPriceâ;
go

create view dbo.vw_SKUPriceâ
as
	select *, dbo.udf_GetSKUPrice(s.id) as Price
	from dbo.SKU as s;
go

--4 ôóíêöèÿ
DROP FUNCTION IF EXISTS dbo.udf_GetSKUPrice;
go

create function dbo.udf_GetSKUPrice (@ID_SKU int)
returns decimal(18, 2)
with execute as caller
as
begin
	declare @price decimal(18, 2);
	set @price = (select 
	(convert(decimal(18, 2), sum(b.value))/
	convert(decimal(18, 2), sum(b.Quantity))) 
	from dbo.Basket b
	where b.ID_SKU = @ID_SKU);
return @price;
end;
go

--5 òðèãåð
DROP TRIGGER IF EXISTS dbo.TR_Basket_insert_update;
go

create trigger dbo.TR_Basket_insert_update
on dbo.Basket
instead of insert
as
begin
	select ID_SKU, case when COUNT(id) > 1 then 0.05 else 0.00 end as c 
	into #tablein from inserted group by ID_SKU;
	insert into dbo.Basket (ID_SKU, ID_Family, Quantity, Value, DiscountValue)
	select 
	i.ID_SKU, 
	i.ID_Family, 
	i.Quantity, 
	(i.Value * (1.00 - (select c from #tablein where ID_SKU = i.ID_SKU))),
	(i.DiscountValue + (select c from #tablein where ID_SKU = i.ID_SKU))
	from inserted i;
end;
go