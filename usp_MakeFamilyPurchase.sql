CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
(
    @FamilySurName varchar(255)
)
AS
BEGIN
	declare @id int
	set @id = (select f.id from dbo.Family f where f.SurName = @FamilySurName)
	if @id = null
		raiserror ('FamilySurName value not found',16,1);
	update dbo.Family
    set BudgetValue = (BudgetValue - (
	select sum(b.value) from dbo.Basket b 
	where b.ID_Family = @id
	))
	where ID = @id
END
go