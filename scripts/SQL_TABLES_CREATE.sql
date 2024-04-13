use test_memory;
go

--����� ��������� ������� ��� ���������� �������� ����������� ��������.
--��������� ����������� ������
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

--������ 
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

--��������� �� ���� � ��������
create table materials(
	id int identity (1,1) not null,
	constraint PK_materials_id primary key clustered(id), 
	name char(20) not null,
	price smallmoney not null,
	description varchar(200)
);

--������������, ����� ����� �������� ������������, ����� ��� ����
create table specification(
	id int identity (1,1) not null,
	constraint PK_specification_id primary key clustered(id), 
	order_id int not null unique,
	constraint FK_order_id foreign key(order_id) references orders(id) 
	on delete cascade
	on update cascade
);

--��������� ���������, �� ���������� � �������������
create table material_specification(
	quantity smallint,
	material_id int not null foreign key references materials(id),
	specification_id int not null foreign key references specification(id),
	constraint PK_material_specification_id primary key clustered(material_id, specification_id)
);
go
