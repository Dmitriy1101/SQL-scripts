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