CREATE PROCEDURE [dbo].[ConfirmUserName]
	@UserName varchar(80),
	@Result bit OUTPUT

AS

SET NOCOUNT ON 
/*Stops the message that shows the count
of the number of rows affected by the statement*/
BEGIN
	IF EXISTS (SELECT UserID FROM Users WHERE UserName = @UserName)
			set @Result = 1
	ELSE
			set @Result = 0
END