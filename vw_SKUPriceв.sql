create view dbo.vw_SKUPriceв
as
	select *, dbo.udf_GetSKUPrice(s.id) as Price
	from dbo.SKU as s;
go