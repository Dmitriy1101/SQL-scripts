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