use test_memory;
go

--ѕри создании заказа будет создаватьс€ спецификаци€
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

--ѕри добавлении/изменении матерь€ла в спецификации перерасчитываетс€ стоимость заказа
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