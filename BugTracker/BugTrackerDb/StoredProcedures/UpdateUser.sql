CREATE PROCEDURE [dbo].[UpdateUser]
(	
	@UserID int
	,@UserName varchar(80)
	,@UserEmail varchar(80)
	,@UserTel varchar(40)
)
AS
	SET NOCOUNT ON

	UPDATE Users set
		UserName = @UserName,
		UserEmail = @UserEmail,
		UserTel = @UserTel
	WHERE UserID = @UserID;

	-- WARNING: Use @@rowcount immediately after the UPDATE statement
	if(@@ROWCOUNT = 0)
	BEGIN
		RAISERROR('Concurrency error detected', 16, 1)
	END