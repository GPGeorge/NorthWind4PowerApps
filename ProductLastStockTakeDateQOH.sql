USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[ProductLastStockTakeDateQOH]    Script Date: 6/28/2025 12:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most recent stocktake date 
			   and Quantity on Hand for a product
=============================================
*/
ALTER PROCEDURE [dbo].[ProductLastStockTakeDateQOH]
	@ProductID as int = 0,
	
	@LocalID as Int =0 OUTPUT,
	@LastStockTakeDate AS Date=Null OUTPUT,
    @LastStockTakeQOH as Int =0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Last StockTake' OUTPUT
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalLastStockTakeDate as Date,
				@LocalLastStockTakeQOH as int;
		SELECT @LocalLastStockTakeDate=  Max([StockTakeDate])
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @LocalLastStockTakeQOH =  QuantityonHand
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID
		AND StockTakeDate = @LocalLastStockTakeDate;
		SET @LastStockTakeQOH =@LocalLastStockTakeQOH;
		SET @LastStockTakeDate =@LocalLastStockTakeDate;
		SET @LocalID = @ProductID;
		SET	@LocalErrorCode = 0 ;
		SET	@LocalMessage  = 'Last StockTakeDate; Product Quantity as of StockTakeDate'; 
	End Try
	BEGIN Catch
		SET @LastStockTakeDate=Null;
		SET @LastStockTakeQOH=0;
		SET @LocalID = @ProductID;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	 End Catch
END
