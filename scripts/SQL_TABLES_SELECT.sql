use test_memory;
go

--select * from dbo.orders;

--select * from dbo.materials;

--select * from dbo.specification;

--select * from dbo.material_specification;

--select distinct quantity, specification_id, material_id into #t from dbo.material_specification;
--select count(specification_id) from #t;

--select * from dbo.workers;

--select id from dbo.get_ord_by_spec_id(1);

--select m.name, m.price, ms.quantity from dbo.material_specification as ms
--join dbo.materials as m on m.id = ms.material_id
--where ms.specification_id = 1

--select o.name as '�����', 
--o.price as '���� ������',
--o.description as '�������� ������',
--ms.quantity  as '���������� ���������',
--m.name as '��������',
--m.price as '����', 
--m.description as '����������'
--from dbo.orders as o
--join dbo.specification as s on o.id = s.order_id
--left join dbo.material_specification as ms on s.id = ms.specification_id
--left join dbo.materials as m on m.id = ms.material_id;

--select * from orders_info
--where [���� ������] is not null
--order by �����;

--select * from orders_info;