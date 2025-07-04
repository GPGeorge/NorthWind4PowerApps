USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[ProductBoughtSinceLastStockTake]    Script Date: 6/28/2025 12:40:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most Total Bought 
			   since last stocktake date for a product
=============================================
*/
ALTER PROCEDURE [dbo].[ProductBoughtSinceLastStockTake]
	@ProductID as int = 0,
	@LocalID as Int =0 OUTPUT,
	@ProductBoughtSinceLastStockTake as int =0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN		
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
		@LocalLastStockTakeDate as date,
		@LocalLastStockTakeQOH as int,
		@LocalErrorCode as int = 0,
		@LocalMessage  as nvarchar(400);
		SELECT @LocalLastStockTakeDate=  Max([StockTakeDate])
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @ProductBoughtSinceLastStockTake= Sum(IsNull(POD.Quantity,0))
		FROM PurchaseOrderDetails As POD INNER JOIN
			PurchaseOrders AS PO ON POD.PurchaseOrderID= PO.PurchaseOrderID
		WHERE ProductID = @ProductiD
			AND  PO.ReceivedDate Is Not Null And PO.ReceivedDate >= @LocalLastStockTakeDate  
		GROUP BY ProductID;
		If @ProductBoughtSinceLastStockTake Is Null
		Set @ProductBoughtSinceLastStockTake=0;
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'product bought since last stock take'; 
	End Try
	BEGIN Catch
		SET @ProductBoughtSinceLastStockTake=0;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	End Catch
END
