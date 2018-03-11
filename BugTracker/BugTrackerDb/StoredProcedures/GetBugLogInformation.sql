CREATE PROCEDURE [dbo].[GetBugLogInformation]
	@BugID int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT BugLogDate, StatusCodeDesc, UserName, BugLogDesc  	
	FROM BugLog
	INNER JOIN StatusCodes
	ON BugLog.StatusCodeID = StatusCodes.StatusCodeID
	INNER JOIN Users
	ON BugLog.UserID = Users.UserID
	WHERE BugID = @BugID;
END;