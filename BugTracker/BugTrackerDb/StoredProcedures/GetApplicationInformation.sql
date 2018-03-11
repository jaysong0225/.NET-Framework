CREATE PROCEDURE [dbo].[GetApplicationInformation]
	@AppID int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT AppName, AppVersion, AppDesc FROM Applications WHERE AppID = @AppID;
END;