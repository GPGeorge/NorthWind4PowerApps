USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[ProductSoldSinceLastStockTake]    Script Date: 6/28/2025 12:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most recent stocktake date 
			   for a product
=============================================
*/
ALTER PROCEDURE [dbo].[ProductSoldSinceLastStockTake]
	@ProductID as int = 0,
	
	@LocalID as Int =0 OUTPUT,
	@ProductSold as int =0 OUTPUT,
	@LastStockTakeDate as DateTime = null OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@LocalProductSold as int, 
			@LocalLastStockTakeDate AS DateTime;
		SELECT @LocalLastStockTakeDate = Max([StockTakeDate])
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @LocalProductSold =IsNull(SUM(Quantity) ,0)
		FROM OrderDetails OD
		WHERE ProductID = @ProductID
			AND OrderID IN(SELECT OrderID
		FROM Orders 
		WHERE IsNull(InvoiceDate,0) >= @LocalLastStockTakeDate);
		SET @LocalID = @ProductID;
		SET @ProductSold= @LocalProductSold;
		SET @LastStockTakeDate= @LocalLastStockTakeDate;
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'Product sold & invoiced since last stocktake'; 
	END Try
	BEGIN Catch
		SET @ProductSold=0;
		SET @LocalID = @ProductID;
		SET @LastStockTakeDate= Null;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
