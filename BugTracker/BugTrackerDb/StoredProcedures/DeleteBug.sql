CREATE PROCEDURE [dbo].[DeleteBug]
	@BugID int
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRY
		BEGIN TRANSACTION;

			DELETE FROM BugLog WHERE BugID = @BugID;

			DELETE FROM Bugs WHERE BugID = @BugID;

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