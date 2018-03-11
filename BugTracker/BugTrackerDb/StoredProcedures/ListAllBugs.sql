CREATE PROCEDURE [dbo].[ListAllBugs]
	@AppID int,
	@StatusCodeID int=0
AS
BEGIN

	SET NOCOUNT ON;

	IF @StatusCodeID = 0 
		BEGIN
			SELECT DISTINCT b.BugID, b.BugDesc
			FROM Applications app
			INNER JOIN Bugs b
			ON app.AppID = b.AppID
			INNER JOIN BugLog bl
			ON b.BugID = bl.BugID
			WHERE app.AppID = @AppID;
		END
	ELSE 
		BEGIN
			SELECT DISTINCT b.BugID, b.BugDesc
			FROM Applications app
			INNER JOIN Bugs b
			ON app.AppID = b.AppID
			INNER JOIN BugLog bl
			ON b.BugID = bl.BugID
			INNER JOIN StatusCodes s
			ON bl.StatusCodeID = s.statusCodeId
			WHERE app.AppID = @AppID AND s.statusCodeId = @StatusCodeID;
		END
END;