
CREATE PROCEDURE [dbo].[AddNewBug]
	@UserID int
	,@AppID int
	,@BugDate DATETIME
	,@BugDesc varchar(40)
	,@BugDetails text
	,@RepSteps text
AS
BEGIN 
	SET NOCOUNT ON;

	DECLARE @BugID AS int

	BEGIN TRY
		BEGIN TRANSACTION;
			INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
				VALUES(@AppID, @UserID, @BugDate, @BugDesc, @BugDetails, @RepSteps);

			set @BugID = SCOPE_IDENTITY()

			INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
				VALUES(GetDate(), 1, @UserID, 'initial bug entered', @BugID);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH;
END;