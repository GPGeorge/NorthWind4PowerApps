USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[AddNewProductToStockTake]    Script Date: 6/28/2025 12:37:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
=============================================
 Author:		George Hepworth
 Create date:   4/22/2025
 Description:	When adding a new product, 
				create an initial stocktake record 
				with 0 quantity and 0 Expected
 =============================================
*/
ALTER PROCEDURE [dbo].[AddNewProductToStockTake] 
	@ProductID as int =0,
	
	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added to Stocktake' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @LastStockTakeDate as date;
			BEGIN TRANSACTION;
				SELECT @LastStockTakeDate =  Max([StockTakeDate]) 
				FROM [dbo].[StockTake]
				WHERE ProductID = @ProductID;
				IF @LastStockTakeDate IS NULL
					BEGIN
						SELECT @LastStockTakeDate = IsNull(AddedOn,GetDate())
						FROM Products
						WHERE ProductID = @ProductID;
						INSERT INTO [dbo].[StockTake]
						(
							StockTakeDate,
							ProductID,
							QuantityOnHand,
							ExpectedQuantity
						)
						VALUES 
						(
							@LastStockTakeDate,
							@ProductID,
							0,
							0
						);
						SET @LocalID = @ProductID;
						SET	@ErrorCode = 0 ;
						SET	@Message  = 'Added StockTake for new product'; 
					END

				SET @LocalID = @ProductID;
				SET	@ErrorCode = 0 ;
				SET	@Message  = ' StockTake exists for product'; 
			Commit Transaction;
	END Try
	BEGIN Catch
		IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
