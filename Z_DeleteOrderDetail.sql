USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteOrderDetail]    Script Date: 6/28/2025 12:18:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =====================================================
 Author:	  George Hepworth
 Create date: 03-27-2025
 Description: Delete one Line Item from OrderDetails
 =====================================================
*/
ALTER PROCEDURE [dbo].[Z_DeleteOrderDetail]
	@OrderDetailID AS int =0,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @OrderStatusID as int;
		Select @OrderStatusID = OrderStatusID
		FROM Orders WHERE OrderID IN
		(SELECT OrderID FROM OrderDetails WHERE OrderDetailID = @OrderDetailID);
		If @OrderStatusID <> 3 --New
			BEGIN
				SET @ErrorCode = 51000;
				SET @Message ='The Order containing this product has been invoiced and can''t be deleted.';
				RETURN
			END
		DELETE FROM [dbo].[OrderDetails]
		WHERE OrderDetailID = @OrderDetailID;
		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'Deleted Order Detail ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
