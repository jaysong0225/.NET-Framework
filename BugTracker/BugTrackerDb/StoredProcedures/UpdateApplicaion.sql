CREATE PROCEDURE [dbo].[UpdateApplicaion]
(
	@AppID int,
	@AppName varchar(40),
	@AppVersion varchar(40),
	@AppDesc varchar(40)
)
AS
	SET NOCOUNT ON

	UPDATE Applications 
	SET	AppName = @AppName,
		AppVersion = @AppVersion,
		AppDesc = @AppDesc
	WHERE AppID = @AppID;

	-- WARNING: Use @@rowcount immediately after the UPDATE statement
	if(@@ROWCOUNT = 0)
	BEGIN
		RAISERROR('Update failed', 16, 1)
	END