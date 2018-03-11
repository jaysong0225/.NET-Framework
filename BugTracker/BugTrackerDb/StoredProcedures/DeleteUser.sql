CREATE PROCEDURE [dbo].[DeleteUser]
	@UserID int
AS

	SET NOCOUNT ON 

	DELETE FROM Users WHERE UserID = @UserID;
	if(@@ROWCOUNT = 0)
		BEGIN
			RAISERROR('User Deletion failed', 16, 1)
		END