CREATE PROCEDURE [dbo].[DeleteApplication]
	@AppName varchar(40),
	@Status bit OUTPUT
AS

	SET NOCOUNT ON 

	IF Not Exists (SELECT BugID FROM Bugs WHERE AppID = 
	(SELECT AppID FROM Applications WHERE AppName = @AppName))
		BEGIN
			DELETE FROM Applications WHERE AppName = @AppName;
			select @Status = 1 
			if(@@ROWCOUNT = 0)
			BEGIN
				RAISERROR('Application deletion failed', 16, 1)
			END
		END
	ELSE
		select @Status = 0