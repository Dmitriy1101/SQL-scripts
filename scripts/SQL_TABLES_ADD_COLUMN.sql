use test_memory;
go

--��������� ����������� ������� � ����� �����������
alter table workers add infofield  as ('s'+ convert(varchar(10), id)+ ' ' + name) persisted;
go

--��� ������ �� �������
alter table dbo.orders 
alter column name char(20) not null;
go

--��� ������  ���������
alter table orders 
add constraint UC_ord_name unique (name);
go

--��� ��������� ���������
alter table materials 
add constraint UC_mat_name unique (name);
go

--������ ���������� ����� ����������
alter table workers 
add constraint UC_wor_nspd unique (name, surname, patronymic, birthdate);
go

