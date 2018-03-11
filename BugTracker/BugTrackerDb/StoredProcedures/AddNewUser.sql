CREATE PROCEDURE [dbo].[AddNewUser]
	@UserName varchar(80)
	,@UserEmail varchar(80)
	,@UserTel varchar(40)
AS

SET NOCOUNT OFF

IF NOT EXISTS (SELECT UserID FROM Users WHERE UserEmail = @UserEmail)
	BEGIN		
		INSERT INTO Users (UserName, UserEmail, UserTel) 
			VALUES(@UserName, @UserEmail, @UserTel);
		RETURN 1
	END
	ELSE
		RETURN 0
