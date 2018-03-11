CREATE PROCEDURE [dbo].[AddNewApplication]
	@AppName varchar(40),
	@AppVersion varchar(40),
	@AppDesc varchar(40)
AS

SET NOCOUNT OFF

IF NOT EXISTS (SELECT AppID FROM Applications WHERE AppName = @AppName)
	BEGIN
		INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES(@AppName, @AppVersion, @AppDesc);
		RETURN 1
	END
ELSE
	RETURN 0
