USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectOrderDetail]    Script Date: 6/28/2025 12:17:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===================================================
Author:		 George Hepworth
Create date: 03/16/2025
Description: Update one line item for OrderDetails
===================================================
*/
ALTER  PROCEDURE [dbo].[Z_SelectOrderDetail] 	 
	 @OrderDetailID AS Int = 0
	,@OrderID as int = 0
	,@ProductID as int = 0
	,@Quantity as smallint = 0
	,@UnitPrice as money = 0
	,@Discount as decimal(6,3) = 0
	,@OrderDetailStatusID as int = 0

	,@LocalID As Int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		SELECT 
		   OrderDetailID
		  ,[OrderID]
		  ,[ProductID]
		  ,[Quantity]
		  ,[UnitPrice]
		  ,[Discount]
		  ,[OrderDetailStatusID]
		FROM [dbo].[OrderDetails]
		WHERE   (@OrderDetailID = 0 OR OrderDetailID = @OrderDetailID)
			AND (@OrderID = 0 OR OrderID = @OrderID)
			AND (@ProductID = 0 OR ProductID = @ProductID)
			AND (@Quantity = 0 OR Quantity = @Quantity)
			AND (@UnitPrice = 0 OR UnitPrice = @UnitPrice)
			AND (@Discount = 0 OR Discount = @Discount)
			AND (@OrderDetailStatusID = 0 OR OrderDetailStatusID = @OrderDetailStatusID);
		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'Selected Order Detail ' --+Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		   OrderDetailID
		  ,[OrderID]
		  ,[ProductID]
		  ,[Quantity]
		  ,[UnitPrice]
		  ,[Discount]
		  ,[OrderDetailStatusID]
		FROM [dbo].[OrderDetails]
		WHERE 1=0;
	END Catch
END
 
