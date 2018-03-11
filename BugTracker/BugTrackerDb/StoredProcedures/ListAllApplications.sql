CREATE PROCEDURE [dbo].[ListAllApplications]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT AppName FROM Applications;

END;