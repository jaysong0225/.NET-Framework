CREATE PROCEDURE [dbo].[GetUserInformation]
	@UserID int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT UserName, UserEmail, UserTel FROM Users WHERE UserID = @UserID;
END;