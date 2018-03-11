CREATE PROCEDURE [dbo].[GetBugInformation]
	@BugID int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT	BugDate
			,BugDesc
			,BugDetails
			,RepSteps
			,FixDate
	FROM Bugs WHERE BugID = @BugID;
END;
