CREATE PROCEDURE [dbo].[UpdateBug]
(	
	@BugID int
	,@AppID int
	,@UserID int
	,@BugSignOff int
	,@BugDate DATETIME
	,@BugDesc varchar(40)
	,@BugDetails text
	,@RepSteps text
	,@FixDate DATETIME
	,@BugLogDesc text
	,@StatusCodeID int
)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

			UPDATE Bugs
			SET AppID = @AppID
				,UserID = @UserID
				,BugSignOff = @BugSignOff
				,BugDate = @BugDate
				,BugDesc = @BugDesc
				,BugDetails = @BugDetails
				,RepSteps = @RepSteps
				,FixDate = @FixDate
			WHERE BugID = @BugID;

			INSERT INTO BugLog 
				(BugLogDate
				,StatusCodeID
				,UserID
				,BugLogDesc
				,BugID) 
			VALUES(GetDate(), @StatusCodeID, @UserID, @BugLogDesc, @BugID);

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