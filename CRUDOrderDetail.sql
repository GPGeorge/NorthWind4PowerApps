USE [DB_48163_nwpa]
GO
/****** Object:  StoredProcedure [dbo].[CRUDOrderDetail]    Script Date: 6/24/2025 12:01:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/25/2025
Description: Replace CRUD Order Details 
=============================================
*/
ALTER PROCEDURE [dbo].[CRUDOrderDetail]
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read   = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected Order Detail
		             Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	 @CRUDType as int = 2
	,@OrderDetailID as int = 0
	,@OrderID as int = 0
	,@ProductID as int = 0
	,@Quantity as smallint = 0
	,@UnitPrice as money = 0
	,@Discount as decimal(6,3) = 0
	,@OrderDetailStatusID as int = null

	,@UnifiedID As Int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE 
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@ReturnValue as nvarchar(4000),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CRUDType= 1 
			BEGIN
				EXEC dbo.Z_AddOrderDetail 
					@OrderID = @OrderID,
					@ProductID = @ProductID,
					@Quantity = @Quantity,  
					@Discount = @Discount , 
					@UnitPrice = @UnitPrice, 
					@OrderDetailStatusID = 1, --new status for new order details
				
					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		ELSE If @CRUDType= 2 
			BEGIN
				EXEC dbo.Z_SelectOrderDetail
					@OrderDetailID = @OrderDetailID,
					@OrderID = @OrderID,
					@ProductID = @ProductID,
					@Quantity = @Quantity,  
					@Discount = @Discount , 
					@UnitPrice = @UnitPrice, 
					@OrderDetailStatusID = @OrderDetailStatusID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		ELSE If @CRUDType= 3 
			BEGIN
				EXEC dbo.Z_UpdateOrderDetail
					@OrderDetailID = @OrderDetailID,
					@ProductID = @ProductID,
					@Quantity = @Quantity,
					@Discount = @Discount,
					@UnitPrice =  @UnitPrice, 
					@OrderDetailStatusID =  @OrderDetailStatusID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @LocalErrorCode OUTPUT,
					@Message = @LocalMessage OUTPUT;
			END
		ELSE If @CRUDType= 4 
			BEGIN
				EXEC dbo.Z_DeleteOrderDetail	
					@OrderDetailID = @OrderDetailID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @LocalErrorCode OUTPUT,
					@Message = @LocalMessage OUTPUT;
			END
		SET @UnifiedID = @LocalID;
		IF @ErrorCode = 0
			BEGIN
				SET @ErrorCode = @ErrorCode;
				SET @Message = @Message;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @ErrorCode,
					@CurrentObject = 'Order Details',
					@CustomErrorCode = @ErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @ErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	End Catch
END
