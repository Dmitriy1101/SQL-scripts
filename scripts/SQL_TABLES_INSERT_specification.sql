use test_memory;
go

--��������� ������������
insert into material_specification(quantity, material_id, specification_id)
values 
(50, (select id from dbo.materials where name = '������'), (select id from get_spec_by_ord_name('������'))),
(10, (select id from dbo.materials where name = '������'), (select id from get_spec_by_ord_name('������'))),
(50, (select id from dbo.materials where name = '������'), (select id from get_spec_by_ord_name('������'))),
(30, (select id from dbo.materials where name = '�����'), (select id from get_spec_by_ord_name('������'))),
(9, (select id from dbo.materials where name = '��������'), (select id from get_spec_by_ord_name('������'))),
(2500, (select id from dbo.materials where name = '������'), (select id from get_spec_by_ord_name('���������� �����'))),
(500, (select id from dbo.materials where name = '������'), (select id from get_spec_by_ord_name('���������� �����'))),
(300, (select id from dbo.materials where name = '�����'), (select id from get_spec_by_ord_name('���������� �����'))),
(30, (select id from dbo.materials where name = '��������'), (select id from get_spec_by_ord_name('���������� �����')));
go

--������ ��� ����� ����������� ��������� ������
--update material_specification
--set quantity = 45 
--where  material_id =  (select id from dbo.materials where name = '������') and specification_id = (select id from get_spec_by_ord_name('������'));