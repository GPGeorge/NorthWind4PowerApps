USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[ProductAvailable]    Script Date: 6/28/2025 12:34:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 03/17/2025
Description: Check Stock Level of Products 
			   for POs and Orders
=============================================
*/
ALTER     PROCEDURE [dbo].[ProductAvailable]
	@ProductID AS Int,
	@CurrentOrder as Int=0,
	@LastStockTakeQOH as Int OUTPUT,
	@ProductBoughtSinceLastStockTake As Int OUTPUT,
	--@ProductOnOrder As Int OUTPUT,
	@ProductSold As Int OUTPUT,
	@LocalProductAvailableToSell As Int OUTPUT,
	--@ProductProjected AS int OUTPUT,
	--@OrderDetailStatus as int OUTPUT,
	@AvailableProductID As Int = 0 OUTPUT,
	--@ProductAllocated as int =0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare 
			@LocalProductSold as int,
			@LocalProductBought as int,
			@LocalID as int,
			--@LocalProductonOrder as int,
			@LocalAllocatedProduct as int,
			@ErrorCode as INT,
			@Message as NVarChar(400),
			@CustomErrorCode as int,
			@CustomErrorMessage as NVarChar(400);
		Set @AvailableProductID = @ProductID;

		-- depending on whether the product is newly added,
		-- it may or may not be in a previous stocktake
		-- this SP adds a stocktake for it, if neccessary
		BEGIN
		Exec dbo.AddNewProductToStockTake
			@ProductID =@ProductID,
			@LocalID = @LocalID OUTPUT,
			@ErrorCode = @ErrorCode OUTPUT,
			@Message = @Message OUTPUT
			SET @LocalErrorCode = Cast(IsNull(@ErrorCode,0) as NVarChar(40));
			SET @LocalMessage = Isnull(@Message,'StockTake Created For ProductID ' 
			+ Cast(@ProductID AS nvarchar(10))) ;
		END
		EXEC dbo.ProductLastStockTakeDateQOH
			@ProductID =@ProductID,
			--@LastStockTakeDate= @LastStockTakeDate OUTPUT,
			@LastStockTakeQOH =@LastStockTakeQOH OUTPUT,			 
			@LocalErrorCode = @LocalErrorCode OUTPUT,
			@LocalMessage = @LocalMessage OUTPUT;
			--Set @LastStockTakeDate=@LastStockTakeDate;
			SET @LastStockTakeQOH= Isnull(@LastStockTakeQOH,0);
			SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
			SET @LocalMessage =  @LocalMessage + '; '+  IsNull(@LocalMessage,' Last StockTake Date ');
		EXEC [dbo].[ProductSoldSinceLastStockTake]
		@ProductID = @ProductID,
	
		@LocalID =@LocalID,
		@ProductSold = @ProductSold OUTPUT,
		@ErrorCode = @LocalErrorCode OUTPUT,
		@Message = @LocalMessage OUTPUT;
		SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
		SET @LocalMessage =  @LocalMessage + '; ' + IsNull(@LocalMessage,' Sold ');
		EXEC [dbo].[ProductBoughtSinceLastStockTake]
		@ProductID = @ProductID,
	
		@LocalID =@LocalID,
		@ProductBoughtSinceLastStockTake = @LocalProductBought OUTPUT,
		@ErrorCode = @LocalErrorCode OUTPUT,
		@Message = @LocalMessage OUTPUT;
		SET @ProductBoughtSinceLastStockTake = IsNull(@LocalProductBought,0);
		SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
		SET @LocalMessage =  @LocalMessage + '; ' + IsNull(@LocalMessage,' Bought ');
		
		--EXEC dbo.[ProductOnOrder]
		--@ProductID = @ProductID,

		--@LocalProductonOrder = @LocalProductOnOrder OUTPUT,
		--@LocalErrorCode =@LocalErrorCode OUTPUT,
		--@LocalMessage =@LocalMessage OUTPUT;

		--SET @ProductOnOrder = IsNull(@LocalProductOnOrder,0);
		--SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
		--SET @LocalMessage =  @LocalMessage + '; ' + IsNull(@LocalMessage,' On Order');


		--EXEC DBO.[ProductAllocated]
		--@ProductID = @ProductID,
		--@LocalProductID= @ProductID,
		--@LocalAllocatedProduct= @LocalAllocatedProduct OUTPUT,
		--@LocalErrorCode =@LocalErrorCode OUTPUT ,
		--@LocalMessage =@LocalMessage OUTPUT

		--SET @ProductAllocated = IsNull(@LocalAllocatedProduct,0);
		--SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
		--SET @LocalMessage =  @LocalMessage + '; ' + IsNull(@LocalMessage,' Allocated'+'.');


	 Set @LocalProductAvailableToSell = 
		 IsNull(@LastStockTakeQOH,0) + 
		 IsNull(@ProductBoughtSinceLastStockTake,0) -
		 IsNull(@ProductSold,0);
	 --Set @ProductProjected =
		-- IsNull(@LastStockTakeQOH,0) + 
		-- IsNull(@ProductBought,0) +
		-- IsNull (@ProductOnOrder,0)-
		-- IsNull(@ProductSold,0) -
		-- IsNull(@CurrentOrder,0);

	 --Set @OrderDetailStatus =
		-- CASE
		-- WHEN @CurrentOrder <=  @LocalProductAvailableToSell 
		-- THEN 1 --Allocated
		-- WHEN @CurrentOrder > @LocalProductAvailableToSell AND @ProductOnOrder = 0
		-- THEN 4 --No Stock
		-- WHEN @CurrentOrder > @LocalProductAvailableToSell AND @ProductOnOrder > 0
		-- THEN 5 --On Order

	 --END 
	 	IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	END Catch
END
