use test_memory;
go

--������ �������������
create view orders_info 
as
	select o.name as '�����', 
	o.price as '���� ������',
	o.description as '�������� ������',
	ms.quantity  as '���������� ���������',
	m.name as '��������',
	m.price as '����', 
	m.description as '����������'
	from dbo.orders as o
	join dbo.specification as s on o.id = s.order_id
	left join dbo.material_specification as ms on s.id = ms.specification_id
	left join dbo.materials as m on m.id = ms.material_id;