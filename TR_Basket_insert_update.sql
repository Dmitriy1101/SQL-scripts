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