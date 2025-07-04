USE [YourDataBaseName]
GO
/****** Object:  StoredProcedure [dbo].[CustomErrorMessage]    Script Date: 6/28/2025 12:19:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 6/6/2025
Description: Trap System and Error Codes and 
			   return custom Error Messages
=============================================
*/
ALTER PROCEDURE [dbo].[CustomErrorMessage]
	@SysErrorCode as int,
	@CurrentObject as nvarchar(120) = 'Object',

	@CustomErrorCode as int = 0 OUTPUT,
	@CustomErrorMessage as nvarchar(400) = 'Unknown Error in {0}' OUTPUT
AS
BEGIN
	SET NOCOUNT ON
    -- Input validation
    IF @SysErrorCode IS NULL
    BEGIN
        SET @CustomErrorCode = -1;
        SET @CustomErrorMessage = 'Invalid input: @SysErrorCode cannot be NULL';
        RETURN;
    END
    -- Ensure @CurrentObject has a default value if NULL
    IF @CurrentObject IS NULL OR LTRIM(RTRIM(@CurrentObject)) = ''
        SET @CurrentObject = 'Object';
  
	BEGIN Try
		DECLARE @SysErrorMessage as nvarchar(400);
		SELECT @SysErrorMessage = SSError
		FROM SSErrors
		WHERE SSErrorID = @SysErrorCode;
		If @SysErrorMessage is null 
		SET @SysErrorMessage = 'Unknown Error in {0}';
		SET @CustomErrorCode = @SysErrorCode;
		SET @CustomErrorMessage = 
			Replace(@SysErrorMessage,'{0}',@CurrentObject);
	END Try
	BEGIN Catch
		SET @SysErrorCode = ERROR_NUMBER();
		SET @CustomErrorMessage = CONCAT('Error in CustomErrorMessage procedure: ', ERROR_MESSAGE());

	 -- Stubbed in logging code
     -- Log the error for debugging (optional - uncomment if you have error logging)
        /*
        INSERT INTO ErrorLog (ErrorNumber, ErrorMessage, ProcedureName, ErrorDate)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'CustomErrorMessage', GETDATE());
        */        
	END Catch
END
