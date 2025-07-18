USE [DB_48163_nwpa]
GO
/****** Object:  StoredProcedure [dbo].[Z_AddOrderDetail]    Script Date: 7/4/2025 6:12:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 06/17/2025
Description: Add a new line item 
               to an order in the OrderDetails table
=============================================
*/
ALTER     PROCEDURE [dbo].[Z_AddOrderDetail] 
	@OrderID int,
	@ProductID int,
	@Quantity smallint = 1 , --Default to an order of 1 item
	@Discount decimal(6,3) = 0 , -- Default to no discount
	@UnitPrice money = 0, 
	@OrderDetailStatusID int = 1, --Default to new

	@LocalID AS int = 0 OUTPUT, 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added Order Detail' OUTPUT 
AS
BEGIN
--We have a business rule disallowing duplicating products in an order. 
--A product can be changed before it is committed.
--A Check restraint on ProductID and OrderID raises an error if we try to add
--a new Order Detail or modify an existing Order Detail that violates the rule.
--In the case of such an error, disallow adding other fields as well.
--I.e. only commit complete inserts.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalProductAvailable as int,
				@LocalProductAvailableToSell as int,
				@LocalProductOnOrder as int,
				@LocalProductInOrder as int,
				@LastStockTakeQOH as int,
				@ProductBought as int,
				@ProductSold as int;
		SET @ErrorCode = 0;

		IF IsNull(@OrderID ,0) = 0 --Required Fields Check
			BEGIN  
			SET @ErrorCode = 55000;
				SET @Message = ' Order is Required ';
				RETURN;
			END
		IF IsNull(@ProductID,0) = 0 --Required Fields Check
			BEGIN  
				SET @ErrorCode = 55100;
				SET @Message = ' Product is Required ';
				RETURN;
			END
		IF IsNull(@UnitPrice,0) = 0 --Required Fields Check
			BEGIN 
				SET @ErrorCode = 55200;
				SET @Message = ' Unit Price is Required ';
				RETURN;
			END	
		IF IsNull(@Quantity,0) = 0 --Required Fields Check
			BEGIN 
				SET @ErrorCode = 55300;
				SET @Message = ' Quantity is Required ';
				RETURN;
			END	
		BEGIN --Check for Duplicate Product on Order
			SELECT @LocalProductInOrder = Count(OrderDetailID)
			FROM OrderDetails
			WHERE OrderID = @OrderID and ProductID = @ProductID;
			BEGIN
				If @LocalProductInOrder <> 0
				BEGIN
					SET @ErrorCode = 58000;
					SET @Message = ' already includes selected product. 
					Select a different product or change the quantity.';
					RETURN;
				END
			END
		END
	--Set Status of this order detail to allocated if product available will cover it
	--or On Order if the amount on order will cover it
	--or No Stock if not enough available and nothing on order for it

		EXEC [dbo].[ProductAvailable]
			 @ProductID = @ProductID, 
			 @LastStockTakeQOH =@LastStockTakeQOH   OUTPUT,
	 		 @ProductBoughtSinceLastStockTake = @ProductBought  OUTPUT,
			 @ProductSold =@ProductSold  OUTPUT,
			 @LocalProductAvailableToSell = @LocalProductAvailable OUTPUT;

			SET @LocalProductAvailableToSell = @LocalProductAvailable;

		EXEC [dbo].[ProductOnOrder]
			 @ProductID = @ProductID,
			 @LocalID =   @ProductID OUTPUT,
			 @LocalProductOnOrder =@LocalProductOnOrder OUTPUT;

			Set @LocalProductOnOrder = @LocalProductOnOrder;

			SET @OrderDetailStatusID =
			CASE WHEN @LocalProductAvailableToSell >= @Quantity
				 THEN 1 --Allocated
				 WHEN @LocalProductAvailableToSell < @Quantity AND @LocalProductOnOrder>0
				 THEN 5 --On Order
				 ELSE 4 --No Stock
			END

		INSERT INTO dbo.OrderDetails
		(
			OrderID,
			ProductID,
			Quantity,
			UnitPrice,
			Discount,
			OrderDetailStatusID
		)
		VALUES
		(
			@OrderID ,
			@ProductID,
			@Quantity ,
			@UnitPrice ,
			@Discount ,
			@OrderDetailStatusID
		) 
		SET @LocalID =  SCOPE_IDENTITY();
		SET @ErrorCode = 0;
		SET @Message = 'Added Order Detail ' +Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
 
