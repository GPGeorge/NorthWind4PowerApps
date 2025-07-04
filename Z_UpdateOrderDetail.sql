USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateOrderDetail]    Script Date: 6/28/2025 12:16:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 03/16/2025
Description: Update one line item 
			   for OrderDetails
=============================================
*/
ALTER  PROCEDURE [dbo].[Z_UpdateOrderDetail] 
	@OrderDetailID AS Int,
	@ProductID AS int,
	@Quantity AS smallint= Null,
	@Discount AS decimal(6,3) =Null,
	@UnitPrice AS money = Null, 
	@OrderDetailStatusID AS int = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
--We have a business rule disallowing duplicating products in an order. 
--A product can be changed before it is committed.
--A Check restraint on ProductID and OrderID raises an error if we try to add
--a new Order Detail or modify an existing Order Detail that violates the rule.
--In the case of such an error, disallow the update of other fields as well.
--I.e. only commit complete updates.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalProductAvailable as int,
		@ThisProductID as int,
		@PreviousProductAvailableToSell as int,
		@CurrentProductOnOrder as int,
		@LastStockTakeQOH as int,
		@ProductBought as int,
		@ProductSold as int; 
		--Set Status of this order detail to: 
		--'Allocated' if product available will cover the quantity in this order detail
		--'On Order' if product available + amount on order will cover it
		--'No Stock' if product available + amount on order will NOT cover it
--Step 1 Check available inventory of the product on this order detail
		SET @ThisProductID=@ProductID;
		EXEC [dbo].[ProductAvailable]
			@ProductID =  @ThisProductID, 
			@LastStockTakeQOH =@LastStockTakeQOH   OUTPUT, --Required parameter, but not used locally
			@ProductBoughtSinceLastStockTake = @ProductBought  OUTPUT, --Required parameter, but not used locally
			@ProductSold = @ProductSold  OUTPUT, --Required parameter, but not used locally
			@LocalProductAvailableToSell = @PreviousProductAvailableToSell OUTPUT; --We only need this OUTPUT
			--Print ' Available to sell Previous ' + Cast(@PreviousProductAvailableToSell as nvarchar(10)); 
--Step 2 Get the amount on Order, if any, but not yet added to inventory
		EXEC [dbo].[ProductOnOrder]
			@ProductID = @ProductID,
			@LocalID =   @ProductID OUTPUT,
			@LocalProductOnOrder  =@CurrentProductOnOrder OUTPUT;
			--Print 'Product currently on Purchase Orders ' + Cast(@CurrentProductOnOrder as nvarchar(10));
			--Print 'Product for this Order ' + Cast(@Quantity  as nvarchar(10));
			--Print 'Available to sell ,minus this order ' + Cast(@PreviousProductAvailableToSell - @Quantity as nvarchar(10));
--Step 3 Use the availability of the Product to determine the status of this order detail following
			--       this update
		SET @CurrentProductOnOrder=@CurrentProductOnOrder;
		SET @OrderDetailStatusID = CASE WHEN @PreviousProductAvailableToSell >= @Quantity
							   	   THEN 1 --Allocated
								   WHEN @PreviousProductAvailableToSell < @Quantity AND @CurrentProductOnOrder>0
								   THEN 5 --On Order
								   ELSE 4 --No Stock
								   END
--Step 4 Update the current order detail with parameters passed in and calculated in Step 4
		UPDATE dbo.OrderDetails
		SET ProductID = IsNull(@ProductID, ProductID),
			Quantity  = IsNull(@Quantity,1),
			UnitPrice = IsNull(@UnitPrice, UnitPrice),
			Discount  = IsNull(@Discount,0),
			OrderDetailStatusID = IsNull(@OrderDetailStatusID ,OrderDetailStatusID) --This is a Safety check, @OrderDetailStatusID should never be null
		WHERE OrderDetailID = @OrderDetailID; 
		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'Updated Order Detail ' +Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
	SET @LocalID = @OrderDetailID;
	SET @ErrorCode = ERROR_NUMBER();
	SET @Message = ERROR_MESSAGE();
END Catch
END
 
