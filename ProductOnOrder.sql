USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[ProductOnOrder]    Script Date: 6/28/2025 12:42:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get the Quantity of a Product 
			   on open, Approved POs
=============================================
*/
ALTER PROCEDURE [dbo].[ProductOnOrder]
	@ProductID as int = 0,

	@LocalProductOnOrder as int = 0 OUTPUT,
	@LocalID as Int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'On Order' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT @LocalProductOnOrder = Sum(IsNull(POD.Quantity,0))
		FROM PurchaseOrderDetails As POD INNER JOIN
			PurchaseOrders AS PO ON POD.PurchaseOrderID= PO.PurchaseOrderID
		WHERE ProductID = @ProductID
			  AND PO.StatusID = 1 --PO is Approved 
		GROUP BY ProductID;

		SET @LocalID = @ProductID;
		SET @LocalProductOnOrder = IsNull(@LocalProductOnOrder,0);
		SET	@LocalErrorCode = 0 ;
		SET	@LocalMessage  = 'Quantity of Product on Purchase Order(s)'; 
	END Try
	BEGIN Catch
		SET @LocalProductOnOrder=0;
		SET @LocalID = @ProductID;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	 END Catch
END
